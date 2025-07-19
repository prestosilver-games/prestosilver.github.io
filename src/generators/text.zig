const std = @import("std");
const rem = @import("rem");

text: []const u8,

const Self = @This();

pub fn gen(self: *const Self, dom: *rem.Dom) !*rem.Dom.Element {
    const paragraph = try dom.makeElement(.html_p);
    try rem.Dom.mutation.elementAppend(dom, paragraph, .{ .cdata = try dom.makeCdata(self.text, .text) }, .Suppress);

    return paragraph;
}
