const std = @import("std");
const rem = @import("rem");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
pub const allocator = gpa.allocator();

pub fn genPage(dom: *rem.Dom, root: *rem.Dom.Element, a: anytype) !void {
    inline for (a) |e| {
        const elem = try e.gen(dom);

        try rem.Dom.mutation.elementAppend(dom, root, .{ .element = elem }, .Suppress);
    }
}

var indent: usize = 0;

pub fn writeElem(writer: anytype, dom: *rem.Dom, element: *rem.Dom.Element) !void {
    if (element.children.items.len == 0) {
        try writer.writeAll("<");
        try writer.writeAll(element.localName(dom));

        const slice = element.attributes.slice();
        if (slice.items(.key).len != 0 and !std.mem.eql(u8, element.localName(dom), "html")) {
            try writer.writeAll(" ");
            for (slice.items(.key), slice.items(.value)) |k, v| {
                try writer.writeAll(k.local_name);
                try writer.writeAll("=\"");
                try writer.writeAll(v);
                try writer.writeAll("\"");
            }
        }
        try writer.writeAll("/>");

        return;
    }

    try writer.writeAll("<");
    try writer.writeAll(element.localName(dom));

    const slice = element.attributes.slice();
    if (slice.items(.key).len != 0 and !std.mem.eql(u8, element.localName(dom), "html")) {
        try writer.writeAll(" ");
        for (slice.items(.key), slice.items(.value)) |k, v| {
            try writer.writeAll(k.local_name);
            try writer.writeAll("=\"");
            try writer.writeAll(v);
            try writer.writeAll("\"");
        }
    }

    try writer.writeAll(">");
    {
        indent += 1;
        defer indent -= 1;

        for (element.children.items) |*child| {
            switch (child.*) {
                .element => |child_elem| try writeElem(writer, dom, child_elem),
                .cdata => |char_data| {
                    try writer.writeAll(char_data.data.items);
                    try writer.writeAll("\n");
                },
            }
        }
    }

    try writer.writeAll("</");
    try writer.writeAll(element.localName(dom));
    try writer.writeAll(">");
}

var wrote: std.ArrayList([]const u8) = .init(allocator);

pub fn writePage(dom: *rem.Dom, root: std.fs.Dir, document: *rem.Dom.Document) !void {
    if (document.element) |elem| {
        const path = elem.getAttribute(.{ .prefix = .none, .namespace = .none, .local_name = "path" }) orelse return;
        const out = std.io.getStdOut();
        const out_writer = out.writer();

        try out_writer.write("{s}\n", .{path});

        for (wrote.items) |other_path| {
            if (std.mem.eql(u8, path, other_path)) {
                return;
            }
        }

        const file = try root.createFile(path, .{});
        defer file.close();

        try writeElem(file.writer(), dom, elem);

        try wrote.append(path);
    }
}
