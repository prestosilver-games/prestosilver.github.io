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
id: []const u8,

pub fn init(file_path: []const u8) Self {
    return .{
        .file_path = file_path,
        .id = "",
    };
}

pub fn gen(self: *const Self, dom: *rem.Dom) !*rem.Dom.Document {
    const document = try dom.makeDocument();

    const html = try dom.makeElement(.html_html);
    try rem.Dom.mutation.documentAppendElement(dom, document, html, .Suppress);

    const head_og_url_meta = try dom.makeElement(.html_meta);
    const head_tw_url_meta = try dom.makeElement(.html_meta);
    {
        const head = try dom.makeElement(.html_head);

        const head_title = try dom.makeElement(.html_title);
        try rem.Dom.mutation.elementAppend(dom, head_title, .{ .cdata = try dom.makeCdata("Prestosilver", .text) }, .Suppress);
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_title }, .Suppress);

        const head_title_meta = try dom.makeElement(.html_meta);
        try head_title_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "name" }, "title");
        try head_title_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "content" }, "Prestosilver");
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_title_meta }, .Suppress);

        const head_og_type_meta = try dom.makeElement(.html_meta);
        try head_og_type_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "property" }, "og:type");
        try head_og_type_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "content" }, "website");
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_og_type_meta }, .Suppress);

        try head_og_url_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "property" }, "og:url");
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_og_url_meta }, .Suppress);

        try head_tw_url_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "property" }, "twitter:url");
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_tw_url_meta }, .Suppress);

        const head_og_title_meta = try dom.makeElement(.html_meta);
        try head_og_title_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "property" }, "og:title");
        try head_og_title_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "content" }, "Prestosilver");
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_og_title_meta }, .Suppress);

        const head_tw_title_meta = try dom.makeElement(.html_meta);
        try head_tw_title_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "property" }, "twitter:title");
        try head_tw_title_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "content" }, "Prestosilver");
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_tw_title_meta }, .Suppress);

        const head_og_description_meta = try dom.makeElement(.html_meta);
        try head_og_description_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "property" }, "og:description");
        try head_og_description_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "content" }, "page-summary");
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_og_description_meta }, .Suppress);

        const head_tw_description_meta = try dom.makeElement(.html_meta);
        try head_tw_description_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "property" }, "twitter:description");
        try head_tw_description_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "content" }, "page-summary");
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_tw_description_meta }, .Suppress);

        const head_description_meta = try dom.makeElement(.html_meta);
        try head_description_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "name" }, "description");
        try head_description_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "content" }, "page-summary");
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_description_meta }, .Suppress);

        const head_css = try dom.makeElement(.html_link);
        try head_css.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "rel" }, "stylesheet");
        try head_css.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "href" }, "/index.css");
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_css }, .Suppress);

        const highlight_css = try dom.makeElement(.html_link);
        try highlight_css.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "rel" }, "stylesheet");
        try highlight_css.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "href" }, "/highlight.min.css");
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = highlight_css }, .Suppress);

        const highlight_js = try dom.makeElement(.html_script);
        try highlight_js.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "src" }, "/highlight.min.js");
        try rem.Dom.mutation.elementAppend(dom, highlight_js, .{ .cdata = try dom.makeCdata("", .text) }, .Suppress);
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = highlight_js }, .Suppress);

        const highlight_zig_js = try dom.makeElement(.html_script);
        try highlight_zig_js.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "src" }, "/highlightzig.min.js");
        try rem.Dom.mutation.elementAppend(dom, highlight_zig_js, .{ .cdata = try dom.makeCdata("", .text) }, .Suppress);
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = highlight_zig_js }, .Suppress);

        const highlight_run = try dom.makeElement(.html_script);
        try rem.Dom.mutation.elementAppend(dom, highlight_run, .{ .cdata = try dom.makeCdata("hljs.highlightAll();", .text) }, .Suppress);
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = highlight_run }, .Suppress);

        const theme_js = try dom.makeElement(.html_script);
        try theme_js.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "src" }, "/theme.js");
        try rem.Dom.mutation.elementAppend(dom, theme_js, .{ .cdata = try dom.makeCdata("", .text) }, .Suppress);
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = theme_js }, .Suppress);
        
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
        try paragraph_date.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "post-date-post");

        try rem.Dom.mutation.elementAppend(dom, block, .{ .element = paragraph_title }, .Suppress);
        try rem.Dom.mutation.elementAppend(dom, block, .{ .element = paragraph_conts }, .Suppress);

        var links: std.ArrayList(Links.LinkData) = .init(dom.allocator);
        defer links.deinit();

        var code: ?*rem.Dom.Element = null;

        const conts = try file.readToEndAlloc(dom.allocator, 10000000);
        var can_split = false;
        var do_split = false;
        var split = std.mem.splitScalar(u8, conts, '\n');
        while (split.next()) |line| {
            if (std.mem.startsWith(u8, line, "%")) {
                const colon_index = std.mem.indexOf(u8, line, ":") orelse continue;
                const kind = std.mem.trim(u8, line[1..colon_index], &std.ascii.whitespace);
                const text = std.mem.trim(u8, line[(colon_index + 1)..], &std.ascii.whitespace);
                if (std.mem.eql(u8, kind, "title")) {
                    try rem.Dom.mutation.elementAppend(dom, title, .{ .cdata = try dom.makeCdata(text, .text) }, .Suppress);
                }

                if (std.mem.eql(u8, kind, "code")) {
                    const lang = try std.fmt.allocPrint(dom.allocator, "language-{s}", .{text});

                    const code_pre = try dom.makeElement(.html_pre);

                    const code_block = try dom.makeElement(.html_code);
                    try code_block.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, lang);

                    try rem.Dom.mutation.elementAppend(dom, code_pre, .{ .element = code_block }, .Suppress);
                    try rem.Dom.mutation.elementAppend(dom, paragraph_conts, .{ .element = code_pre }, .Suppress);

                    code = code_block;
                    can_split = false;
                    do_split = false;
                }

                if (std.mem.eql(u8, kind, "end")) {
                    if (std.mem.eql(u8, text, "code"))
                        code = null;
                    can_split = false;
                    do_split = false;
                }

                if (std.mem.eql(u8, kind, "hide")) {
                    break;
                }

                if (std.mem.eql(u8, kind, "url")) {
                    // set url
                    const page_url = try std.fmt.allocPrint(dom.allocator, "posts/{s}.html", .{text});
                    try html.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "path" }, page_url);
                    try head_og_url_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "content" }, page_url);
                    try head_tw_url_meta.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "content" }, page_url);
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
                    can_split = false;
                    do_split = false;
                }

                continue;
            }

            if (code) |code_block| {
                const text = line;

                if (text.len == 0 and can_split) {
                    do_split = true;
                    can_split = false;
                } else if (text.len != 0) {
                    if (do_split) {
                        try rem.Dom.mutation.elementAppend(dom, code_block, .{ .cdata = try dom.makeCdata("", .text) }, .Suppress);
                        do_split = false;
                    }
                    try rem.Dom.mutation.elementAppend(dom, code_block, .{ .cdata = try dom.makeCdata(text, .text) }, .Suppress);
                    can_split = true;
                }
            } else {
                const text = std.mem.trim(u8, line, &std.ascii.whitespace);

                if (text.len == 0 and can_split) {
                    do_split = true;
                    can_split = false;
                } else if (text.len != 0) {
                    if (do_split) {
                        try rem.Dom.mutation.elementAppend(dom, paragraph_conts, .{ .element = try dom.makeElement(.html_br) }, .Suppress);
                        try rem.Dom.mutation.elementAppend(dom, paragraph_conts, .{ .element = try dom.makeElement(.html_br) }, .Suppress);
                        do_split = false;
                    }

                    try rem.Dom.mutation.elementAppend(dom, paragraph_conts, .{ .cdata = try dom.makeCdata(text, .text) }, .Suppress);
                    do_split = true;
                    can_split = true;
                }
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
