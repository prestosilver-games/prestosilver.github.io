const std = @import("std");
const rem = @import("rem");

pub const LinkData = struct {
    name: []const u8,
    path: []const u8,
};

data: []const LinkData,

const Links = @This();

pub fn gen(self: *const Links, dom: *rem.Dom) !*rem.Dom.Element {
    const link_section = try dom.makeElement(.html_div);

    for (self.data) |l| {
        const link_box = try dom.makeElement(.html_div);
        try link_box.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "link");

        const link = try dom.makeElement(.html_a);
        try rem.Dom.mutation.elementAppend(dom, link, .{ .cdata = try dom.makeCdata(l.name, .text) }, .Suppress);

        try link.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "href" }, l.path);
        try rem.Dom.mutation.elementAppend(dom, link_box, .{ .element = link }, .Suppress);

        // add to parent
        try rem.Dom.mutation.elementAppend(dom, link_section, .{ .element = link_box }, .Suppress);
    }

    try link_section.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "links");

    return link_section;
}
