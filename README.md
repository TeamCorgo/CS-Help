# Help System Extraction & Modernization

The game references external Windows help and context files from within the game itself. Specifically, players are unable to access or read BGM donor history entries on modern systems. These help files consist of linked pages containing embedded image content.

Modern versions of Windows no longer support these legacy help formats, so the content must be extracted and converted into a more accessible modern format.

The application `MVIEWER2.EXE` is used to read the English compiled help package `METALSTO.MVB`. Inspection of `MVIEWER2.EXE` identifies it as a Microsoft Multimedia Viewer application.

A utility named **HelpDeco V2.1** can decompile the packed `.MVB` archive into more accessible formats. While the exported formats are easier to work with, they are still not ideal for long-term preservation or web publishing. The extracted formats include:

* `.rtf` — Rich Text Format articles
* `.bmp` — Standard bitmap images
* `.shg` — Segmented Hypergraphics with clickable regions

Another utility, **Help Scribble**, can read `.shg` files and export them as flat `.bmp` images. This process removes the embedded clickable mapping regions, but those regions should be straightforward to recreate using HTML image maps.

A custom conversion tool will likely be required to process each `.rtf` document into modern `.html`.

## File Format Notes

* `.rtf` is a basic rich text format and is relatively easy to parse and convert.
* `.bmp` files already contain usable image content and require no additional processing.
* `.shg` files are interactive images that link to articles depending on where the user clicks. Additional tooling or manual recreation will be required to preserve this functionality.

# Workflow explained:

* Decompress `METALSTO.MVB` using HelpDeco V2.1 (`HELPDECO.EXE /g /i /s 1 METALSTO.MVB`)
* Convert extracted `.shg` files into non-interactive `.bmp` images using Help Scribble
* Convert extracted `.rtf` articles into modern `.html` using `convert.sh`
* Fix hyperlinks between documents and links to images (manual process)
* Publish the resulting documentation in a modern, accessible format (website)

# Thoughts
This process converts documents that were previously "locked" in an inconvenient format into something that is readily accessible. However, the conversion effort revealed that the in-game manual itself has several quality issues, including problems with menu layouts and missing content. Information introduced in the v1.1 patch notes was never incorporated back into the manual, leaving details such as weapon statistics absent. Likewise, information contained in the Prima Strategy Guide is also missing from the manual, resulting in knowledge being fragmented across multiple sources.

Ideally, there should be a single authoritative location that serves as the primary reference for players seeking information about the game.

# Shout out
The absolute legend Matt Jernigan also converted the documents back around 2019. He documented the process in a [blog post](https://juanitogan.itch.io/cyberstorm-patch/devlog/80329/patch-release-7-recompiled-help-files) and published the [source code for the conversion tools](https://github.com/juanitogan/rbxit/tree/master/helpfile-tools).

Matt's tools regenerate the help files into a format that closely recreates the original 1996 experience. The goal of this project, however, is to take an additional step forward by integrating information from the v1.1 patch, the *Prima Strategy Guide*, and YouTube resources. Rather than simply providing a modern viewer for the original help files, the intent is to create a comprehensive and modern replacement for the game's documentation.

This difference in approach should not be interpreted as a criticism of Matt's work or an attempt to devalue it. His efforts were—and continue to be—massively impressive. Reconstructing the original help system and publishing the accompanying tools was an extraordinary achievement, and it remains an invaluable contribution to the community. The distinction lies solely in the desired final outcome: preserving and recreating the original experience versus expanding and consolidating information from multiple sources into a unified reference.
