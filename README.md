<p align="center">
  <img src="./images/web_header.gif" alt="MissionForce: CyberStorm Logo">
</p>
A fan-driven historical archive dedicated to MissionForce: CyberStorm — Sierra’s dark, tactical science-fiction wargame that combined brutal turn-based combat, persistent pilots, and corporate warfare into one of the most unforgiving strategy experiences of the 1990s.


# Help / Game Manual
Given the complexity of the game’s mechanics, the absence of a proper physical manual was a disappointment [voiced by players](https://groups.google.com/g/comp.sys.ibm.pc.games.strategic/c/KwuVW36djSw/m/vDhxq69hIDsJ). 

> "However, the choice to not have a paper  manual was not one that many were, shall we say, fond of." In addition to the lack of heft in the box, many missed explicitly detailed statistics for the weapons. Some wanted more things to be able to read off-line. Others had trouble printing sections of the manual on their printer."
>
> — PATCH.TXT document (post install from v1.1)

Modern operating systems are unable to open the original help reader `METALSTO.MVB`. While the GOG release includes the manual, all in-game calls to the help system have been disabled to prevent error messages from being displayed. The Bioderm donor history provides interesting background lore that is not directly presented during gameplay, but is preserved within the help system. As a result, new players typically miss this content entirely.

<p align="center">
  <img src="./images/example broken.png" alt="Error displayed from Medbay">
</p>
<p align="center">
  <img src="./images/example working.png " alt="Working help example">
</p>


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
