const std = @import("std");
const rem = @import("rem");
const util = @import("../util.zig");

const Links = @import("../generators/links.zig");
const Block = @import("../generators/block.zig").Block;
const Split = @import("../generators/block.zig").Split;
const List = @import("../generators/list.zig");
const Text = @import("../generators/text.zig");

pub fn gen(dom: *rem.Dom) !*rem.Dom.Document {
    const document = try dom.makeDocument();

    const html = try dom.makeElement(.html_html);
    try rem.Dom.mutation.documentAppendElement(dom, document, html, .Suppress);
    try html.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "path" }, "index.html");

    {
        const head = try dom.makeElement(.html_head);

        const head_title = try dom.makeElement(.html_title);
        try rem.Dom.mutation.elementAppend(dom, head_title, .{ .cdata = try dom.makeCdata("Prestosilver", .text) }, .Suppress);

        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = head_title }, .Suppress);

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

        const highlight_run = try dom.makeElement(.html_script);
        try rem.Dom.mutation.elementAppend(dom, highlight_run, .{ .cdata = try dom.makeCdata("hljs.highlightAll();", .text) }, .Suppress);
        try rem.Dom.mutation.elementAppend(dom, head, .{ .element = highlight_run }, .Suppress);

        try rem.Dom.mutation.elementAppend(dom, html, .{ .element = head }, .Suppress);
    }

    {
        const body = try dom.makeElement(.html_body);
        try rem.Dom.mutation.elementAppend(dom, html, .{ .element = body }, .Suppress);

        const root = try dom.makeElement(.html_div);
        try root.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "page-content");
        try rem.Dom.mutation.elementAppend(dom, body, .{ .element = root }, .Suppress);

        {
            const title = try dom.makeElement(.html_h1);
            try rem.Dom.mutation.elementAppend(dom, title, .{ .cdata = try dom.makeCdata("Prestosilver", .text) }, .Suppress);
            try title.appendAttribute(dom.allocator, .{ .prefix = .none, .namespace = .none, .local_name = "class" }, "page-title");

            // add to parent
            try rem.Dom.mutation.elementAppend(dom, root, .{ .element = title }, .Suppress);
        }

        try util.genPage(dom, root, .{
            Block(Text){
                .heading = "About",
                .conts = .{
                    .text = "I am a CS major who loves to program. " ++
                        "I have many small projects that I work on in my free time, these include games, software, and tools. " ++
                        "I am fluent in writing in Zig, Nim, Python, Html, CSS, C, Rust, C#, Cpp, x86asm, z80asm, Markdown, GDScript, and Slam. " ++
                        "I also have experience in Forth, Javascript, GLSL, Ruby, Lua and TS. " ++
                        "I plan to learn Haskell, and GoLang, Cobol (mabye), in the future. " ++
                        "There are many hobbies I enjoy including Book binding, Bowling, Papercraft, Doodling, and Sewing.",
                },
            },
            Block(Links){
                .heading = "Links",
                .conts = .{ .data = &.{
                    .{ .name = "Linkedin", .path = "https://www.linkedin.com/in/prestosilver/" },
                    .{ .name = "Discord", .path = "https://discord.com/invite/vrVVXktmfV" },
                    .{ .name = "Youtube", .path = "https://www.youtube.com/channel/UCn3KTSGb3DbbGlS3hYGmsTA" },
                    .{ .name = "Itch", .path = "https://prestosilver.itch.io" },
                    .{ .name = "GitHub", .path = "https://github.com/prestosilver" },
                    .{ .name = "Steam", .path = "https://store.steampowered.com/dev/presosilver" },
                    .{ .name = "Email", .path = "mailto:prestosilver.ptp@gmail.com" },
                    .{ .name = "Google Play", .path = "https://play.google.com/store/apps/dev?id=7954891124376186534" },
                    .{ .name = "GitHub (Organization)", .path = "https://github.com/prestosilver-games" },
                } },
            },
            Split(Block(List)){
                .class = "split",
                .conts = &.{
                    Block(List){
                        .heading = "Games",
                        .conts = .{
                            .folder = "posts/games",
                        },
                    },
                    Block(List){
                        .heading = "Projects",
                        .conts = .{
                            .folder = "posts/projs",
                        },
                    },
                    Block(List){
                        .heading = "Rants",
                        .conts = .{
                            .folder = "posts/rants",
                        },
                    },
                },
            },
        });
    }

    return document;
}
