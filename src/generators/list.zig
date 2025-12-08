const std = @import("std");
const rem = @import("rem");
const util = @import("../util.zig");

const PostPage = @import("../pages/post.zig");

folder: []const u8,

const Self = @This();

pub fn gen(self: *const Self, dom: *rem.Dom) !*rem.Dom.Element {
    const list_section = try dom.makeElement(.html_div);
    try list_section.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "list");

    var elems: std.ArrayList(*rem.Dom.Element) = .init(dom.allocator);
    defer elems.deinit();

    const walker = try std.fs.cwd().openDir(self.folder, .{ .iterate = true });
    var iter = walker.iterate();

    while (try iter.next()) |item| {
        switch (item.kind) {
            .file => {
                const link = try dom.makeElement(.html_a);

                const block = try dom.makeElement(.html_div);
                try block.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "post");
                try rem.Dom.mutation.elementAppend(dom, link, .{ .element = block }, .Suppress);

                const paragraph_title = try dom.makeElement(.html_span);
                try paragraph_title.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "post-title");

                const paragraph_link = try dom.makeElement(.html_p);
                try paragraph_link.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "post-link");
                try rem.Dom.mutation.elementAppend(dom, paragraph_link, .{ .cdata = try dom.makeCdata("Read more", .text) }, .Suppress);

                const paragraph_conts = try dom.makeElement(.html_div);
                try paragraph_conts.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "post-content");

                const paragraph_date = try dom.makeElement(.html_p);
                try paragraph_date.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "post-date");

                try rem.Dom.mutation.elementAppend(dom, block, .{ .element = paragraph_title }, .Suppress);
                try rem.Dom.mutation.elementAppend(dom, block, .{ .element = paragraph_conts }, .Suppress);
                try rem.Dom.mutation.elementAppend(dom, paragraph_conts, .{ .element = paragraph_link }, .Suppress);

                var file = try walker.openFile(item.name, .{});
                defer file.close();

                const conts = try file.readToEndAlloc(dom.allocator, 10000000);

                var can_split = false;
                var split = std.mem.splitScalar(u8, conts, '\n');
                while (split.next()) |line| {
                    if (std.mem.startsWith(u8, line, "%")) {
                        const colon_index = std.mem.indexOf(u8, line, ":") orelse continue;
                        const kind = std.mem.trim(u8, line[1..colon_index], &std.ascii.whitespace);
                        const text = std.mem.trim(u8, line[(colon_index + 1)..], &std.ascii.whitespace);
                        if (std.mem.eql(u8, kind, "title")) {
                            try rem.Dom.mutation.elementAppend(dom, paragraph_title, .{ .cdata = try dom.makeCdata(text, .text) }, .Suppress);
                        }

                        if (std.mem.eql(u8, kind, "hide")) {
                            break;
                        }

                        if (std.mem.eql(u8, kind, "date")) {
                            try rem.Dom.mutation.elementAppend(dom, paragraph_date, .{ .cdata = try dom.makeCdata(text, .text) }, .Suppress);

                            try link.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "id" }, text);
                        }

                        continue;
                    }

                    const text = std.mem.trim(u8, line, &std.ascii.whitespace);

                    if (text.len == 0 and can_split) {
                        try rem.Dom.mutation.elementAppend(dom, paragraph_conts, .{ .element = try dom.makeElement(.html_br) }, .Suppress);
                        can_split = false;
                    } else if (text.len != 0) {
                        try rem.Dom.mutation.elementAppend(dom, paragraph_conts, .{ .cdata = try dom.makeCdata(text, .text) }, .Suppress);
                        try rem.Dom.mutation.elementAppend(dom, paragraph_conts, .{ .element = try dom.makeElement(.html_br) }, .Suppress);
                        can_split = true;
                    }
                }

                try rem.Dom.mutation.elementAppend(dom, paragraph_conts, .{ .element = paragraph_date }, .Suppress);

                if (link.getAttribute(.{ .prefix = .none, .namespace = .none, .local_name = "id" })) |_| {
                    try elems.append(link);

                    const page: PostPage = .init(try std.fmt.allocPrint(dom.allocator, "{s}/{s}", .{ self.folder, item.name }));
                    const conts = try page.gen(dom);
                    if (page.id == "")
                        return error.MissingPageId;

                    const page_url = try std.fmt.allocPrint(dom.allocator, "posts/{s}.html", .{page.id});

                    try util.writePage(dom, try std.fs.cwd().openDir("root", .{}),);

                    try link.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "href" }, page_url);
                }
            },
            else => {},
        }
    }

    std.mem.sort(*rem.Dom.Element, elems.items, {}, struct {
        pub fn lt(_: void, a: *rem.Dom.Element, b: *rem.Dom.Element) bool {
            return std.mem.lessThan(
                u8,
                b.getAttribute(.{ .prefix = .none, .namespace = .none, .local_name = "id" }).?,
                a.getAttribute(.{ .prefix = .none, .namespace = .none, .local_name = "id" }).?,
            );
        }
    }.lt);

    for (elems.items) |elem| {
        try rem.Dom.mutation.elementAppend(dom, list_section, .{ .element = elem }, .Suppress);
    }

    return list_section;
}
