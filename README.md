# LaTeX Reference Manager

LaTeX Reference Manager provides a small, Makefile-driven helper for creating and managing cross-document references in LaTeX projects. It makes it easy to reference PDFs produced by other projects and to manage external links (web pages, externally hosted PDFs, etc.).

## Quick start

Prerequisites:

- A TeX distribution with PDFLaTeX (for Debian/Ubuntu a convenient option is `texlive-full`).
- GNU Make.

Install system packages (Debian/Ubuntu):

```bash
sudo apt-get install texlive-full make
```

Add the manager to your project (recommended as a git submodule):

```bash
git submodule add git@github.com:bringauto/latex-references-manager.git
```

Initialize the manager from the repository root:

```bash
make -C latex-references-manager init
```

For more initialization options, see the [Initialization options and example](#initialization-options-and-example) section below.

## Example project Makefile

Reuse the `Makefile` in `example/` by including `Makefile.common` from the repository root. A minimal project Makefile looks like this:

```make
PROJECT_NAME := example
REPO_ROOT_DIR := ../

include $(REPO_ROOT_DIR)/Makefile.common

$(eval $(call COMMON_LOGIC, $(PROJECT_NAME), $(REPO_ROOT_DIR)))
```

Set `PROJECT_NAME` to your main `.tex` filename (without `.tex`) and `REPO_ROOT_DIR` to the path to the repository root.

## Initialization options and example

When using the manager, you can customize:

- where you put the submodule in the first place,
- where you want to create files or symlinks for the manager in your project (via the `INIT_DIR` variable).
- whether you want to create symlink to the `references.tex` file in the repository.

Assume the following:

- The submodule directory is `another_dir/subdir/latex-references-manager` inside your repository.
- You want to create the manager files/symlinks inside `another_dir/` (so the `another_dir` will contain `Makefile.common`, `references_lib/` etc.).
- You want to create a symlink to the `references.tex` file in the repository root.

Then initialize the manager by running:

```bash
make -C another_dir/subdir/latex-references-manager init INIT_DIR=../../
```

This creates symlinks from the project root so `Makefile.common` and the LaTeX library files are accessible.

See, that the `INIT_DIR` is relative to the submodule (`latex-references-manager`) itself.

## Using references between projects

1. Add a record for each external document in the root `references.tex` file. For a local PDF built by another project use:

```latex
\createref{document1}{path/to/output}
```

`path/to/output` is relative to the repository root and should point to the PDF output path without the `.pdf` extension.

1. Include the helper macros in your document:

```latex
\input{references_lib/references_lib.tex}
```

1. Use a registered reference in your document:

```latex
\href{\getref{document1}}{Link to document1.pdf}
```

## External references (web pages and remote PDFs)

You can register and use external URLs (web pages, externally hosted PDFs) using `\createextref` and `\getextref`.

Register an external reference in `references.tex`:

```latex
\createextref{bringauto}{https://bringauto.com}
```

Use it in your document:

```latex
\href{\getextref{bringauto}}{Bringauto homepage}
% or
\url{\getextref{bringauto}}
```

Notes and tips:

- Always include the URL scheme (`http://` or `https://`) when registering an external reference.
- `\getextref{<name>}` returns the registered URL and can be used with `\href`, `\url` or other link macros.
- URLs are not validated at build time; if a link is broken, update `references.tex` accordingly.
- If a URL contains LaTeX-sensitive characters, prefer `\url{\getextref{...}}` or escape as needed.

## Reference naming and path requirements

### Reference naming rules

- Use only alphanumeric characters and underscores
- Names are case-sensitive

### Path requirements

- Must be relative to project root
- Cannot contain spaces or special characters
- Forward slashes must be used as path separators

## Configuration

Edit `references_config.tex` at the repository root to change behavior:

- Toggle output mode (pdf/html):

```latex
\def\pdfhtmlmode{pdf} % or \def\pdfhtmlmode{html}
```

- Set HTML prefix (used when HTML support is implemented):

```latex
\def\htmlprefix{https://bringauto.com/en/}
```

Note: HTML output is currently not supported; implementing it requires tools such as `latexml`.

## Build and test

To build the example project in `example/`:

```bash
make -C example
```

Use `make -C example clean` to remove temporary files, or `make -C example cleanall` to also remove the generated PDF.

## Troubleshooting

- If your references do not resolve, check that `references.tex` entries use correct names and paths.
- For external links, verify the URL scheme and encoding.
- If LaTeX cannot find `references_lib/references_lib.tex` ensure you ran `init` or that `TEXINPUTS` is configured by your top-level Makefile.

## License

This project is provided under the terms of the LICENSE file in the repository root.
