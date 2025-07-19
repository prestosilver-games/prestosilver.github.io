const std = @import("std");
const rem = @import("rem");
const util = @import("../util.zig");

const Links = @import("../generators/links.zig");
const Block = @import("../generators/block.zig").Block;
const Split = @import("../generators/block.zig").Split;
const List = @import("../generators/list.zig");
const Text = @import("../generators/text.zig");

const Self = @This();

file_path: []const u8,
id: usize,

var last_id: usize = 0;

pub fn init(file_path: []const u8) Self {
    last_id += 1;

    return .{
        .file_path = file_path,
        .id = last_id,
    };
}

pub fn gen(self: *const Self, dom: *rem.Dom) !*rem.Dom.Document {
    const document = try dom.makeDocument();
    const page_url = try std.fmt.allocPrint(dom.allocator, "posts/{}.html", .{self.id});

    const html = try dom.makeElement(.html_html);
    try rem.Dom.mutation.documentAppendElement(dom, document, html, .Suppress);
    try html.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "path" }, page_url);

    {
        const head = try dom.makeElement(.html_head);

        const head_title = try dom.makeElement(.html_title);
        try rem.Dom.mutation.elementAppend(dom, head_title, .{ .cdata = try dom.makeCdata("Prestosilver", .text) }, .Suppress);

        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_title }, .Suppress);

        const head_css = try dom.makeElement(.html_link);
        try head_css.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "rel" }, "stylesheet");
        try head_css.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "href" }, "/index.css");
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_css }, .Suppress);

        try rem.Dom.mutation.elementAppend(dom, html, .{ .element = head }, .Suppress);
    }

    {
        const body = try dom.makeElement(.html_body);
        try rem.Dom.mutation.elementAppend(dom, html, .{ .element = body }, .Suppress);

        const root = try dom.makeElement(.html_div);
        try root.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "page-content");
        try rem.Dom.mutation.elementAppend(dom, body, .{ .element = root }, .Suppress);

        const title = try dom.makeElement(.html_h1);
        try title.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "page-title");

        // add to parent
        try rem.Dom.mutation.elementAppend(dom, root, .{ .element = title }, .Suppress);

        var file = try std.fs.cwd().openFile(self.file_path, .{});
        defer file.close();

        var block = try dom.makeElement(.html_div);
        try block.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "block");
        try rem.Dom.mutation.elementAppend(dom, root, .{ .element = block }, .Suppress);

        const paragraph_title = try dom.makeElement(.html_span);
        try paragraph_title.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "block-title");
        try rem.Dom.mutation.elementAppend(dom, paragraph_title, .{ .cdata = try dom.makeCdata("About", .text) }, .Suppress);

        var paragraph_conts = try dom.makeElement(.html_div);
        try paragraph_conts.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "block-content");

        const paragraph_date = try dom.makeElement(.html_p);
        try paragraph_date.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "post-date");

        try rem.Dom.mutation.elementAppend(dom, block, .{ .element = paragraph_title }, .Suppress);
        try rem.Dom.mutation.elementAppend(dom, block, .{ .element = paragraph_conts }, .Suppress);

        var links: std.ArrayList(Links.LinkData) = .init(dom.allocator);
        defer links.deinit();

        const conts = try file.readToEndAlloc(dom.allocator, 10000000);
        var can_split = false;
        var split = std.mem.splitScalar(u8, conts, '\n');
        while (split.next()) |line| {
            if (std.mem.startsWith(u8, line, "%")) {
                const colon_index = std.mem.indexOf(u8, line, ":") orelse continue;
                const kind = std.mem.trim(u8, line[1..colon_index], &std.ascii.whitespace);
                const text = std.mem.trim(u8, line[(colon_index + 1)..], &std.ascii.whitespace);
                if (std.mem.eql(u8, kind, "title")) {
                    try rem.Dom.mutation.elementAppend(dom, title, .{ .cdata = try dom.makeCdata(text, .text) }, .Suppress);
                }

                if (std.mem.eql(u8, kind, "hide")) {
                    break;
                }

                if (std.mem.eql(u8, kind, "date")) {
                    try rem.Dom.mutation.elementAppend(dom, paragraph_date, .{ .cdata = try dom.makeCdata("Last Modified ", .text) }, .Suppress);
                    try rem.Dom.mutation.elementAppend(dom, paragraph_date, .{ .cdata = try dom.makeCdata(text, .text) }, .Suppress);
                }

                if (std.mem.eql(u8, kind, "link")) {
                    const equal_index = std.mem.indexOf(u8, text, "=") orelse continue;
                    const name = std.mem.trim(u8, text[0..equal_index], &std.ascii.whitespace);
                    const path = std.mem.trim(u8, text[(equal_index + 1)..], &std.ascii.whitespace);

                    try links.append(.{ .name = name, .path = path });
                }

                if (std.mem.eql(u8, kind, "head")) {
                    const tmp_title = try dom.makeElement(.html_span);
                    try tmp_title.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "block-title");
                    try rem.Dom.mutation.elementAppend(dom, tmp_title, .{ .cdata = try dom.makeCdata(text, .text) }, .Suppress);

                    paragraph_conts = try dom.makeElement(.html_div);
                    try paragraph_conts.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "block-content");

                    block = try dom.makeElement(.html_div);
                    try block.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "block");
                    try rem.Dom.mutation.elementAppend(dom, root, .{ .element = block }, .Suppress);

                    try rem.Dom.mutation.elementAppend(dom, block, .{ .element = tmp_title }, .Suppress);
                    try rem.Dom.mutation.elementAppend(dom, block, .{ .element = paragraph_conts }, .Suppress);
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

        try links.appendSlice(&.{
            .{ .name = "Home", .path = "/index.html" },
        });

        try util.genPage(dom, root, .{Block(Links){
            .heading = "Links",
            .conts = .{
                .data = links.items,
            },
        }});

        try rem.Dom.mutation.elementAppend(dom, root, .{ .element = paragraph_date }, .Suppress);
    }

    return document;
}
