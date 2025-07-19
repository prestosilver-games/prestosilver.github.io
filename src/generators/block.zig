const std = @import("std");
const rem = @import("rem");

pub fn Block(comptime T: type) type {
    return struct {
        const Self = @This();

        heading: []const u8,
        conts: T,

        pub fn gen(self: *const Self, dom: *rem.Dom) !*rem.Dom.Element {
            const heading = try dom.makeElement(.html_h2);
            try rem.Dom.mutation.elementAppend(dom, heading, .{ .cdata = try dom.makeCdata(self.heading, .text) }, .Suppress);
            try heading.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "block-title");

            const content_block = try dom.makeElement(.html_div);
            try content_block.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "block-content");

            const cont = try self.conts.gen(dom);
            try rem.Dom.mutation.elementAppend(dom, content_block, .{ .element = cont }, .Suppress);

            const block_section = try dom.makeElement(.html_div);
            try block_section.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "block");
            try rem.Dom.mutation.elementAppend(dom, block_section, .{ .element = heading }, .Suppress);
            try rem.Dom.mutation.elementAppend(dom, block_section, .{ .element = content_block }, .Suppress);

            return block_section;
        }
    };
}

pub fn Split(comptime T: type) type {
    return struct {
        const Self = @This();

        class: []const u8,
        conts: []const T,

        pub fn gen(self: *const Self, dom: *rem.Dom) !*rem.Dom.Element {
            const content_block = try dom.makeElement(.html_div);
            try content_block.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, self.class);

            for (self.conts) |c| {
                const cont = try c.gen(dom);
                try rem.Dom.mutation.elementAppend(dom, content_block, .{ .element = cont }, .Suppress);
            }

            return content_block;
        }
    };
}
