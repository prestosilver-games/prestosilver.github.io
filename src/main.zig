const std = @import("std");
const rem = @import("rem");

const util = @import("util.zig");
const home = @import("pages/home.zig");

const allocator = util.allocator;

pub fn main() !void {
    var dom = rem.Dom{ .allocator = allocator };
    defer dom.deinit();

    const root = try std.fs.cwd().openDir("root", .{});

    const home_page = try home.gen(&dom);

    try util.writePage(&dom, root, home_page);
}
