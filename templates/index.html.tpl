<!doctype html>
<html>

<head>
    <meta charset="utf-8" />
    <title>Helm Chart Repository ${repository_name}</title>
    <!-- Inspired by: <https://www.npmjs.com/package/github-markdown-css> -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/2.10.0/github-markdown.min.css" integrity="sha256-Ndk1ry+oGNFEaXt4kxlW/SYLbxat1O0DhaDd+lob0SY=" crossorigin="anonymous" />
    <!-- Inspired by: <https://github.com/showdownjs/showdown> -->
    <script type="text/javascript" src="https://cdn.rawgit.com/showdownjs/showdown/1.9.0/dist/showdown.min.js"></script>
    <script>
        // Inspired by <https://github.com/showdownjs/showdown/wiki/Tutorial:-Markdown-editor-using-Showdown>
        document.addEventListener('DOMContentLoaded', function () {
            var text = document.getElementById('sourceTA').value,
                target = document.getElementById('renderedMarkdown'),
                converter = new showdown.Converter(),
                html = converter.makeHtml(text);
            target.innerHTML = html;
        }, false);
    </script>
    <style>
        .markdown-body {
            box-sizing: border-box;
            min-width: 200px;
            max-width: 980px;
            margin: 0 auto;
            padding: 45px;
        }

        @media (max-width: 780px) {
            .markdown-body {
                padding: 15px;
            }
        }
    </style>
</head>


<body>
    <textarea style="display:none" id="sourceTA">${rendered_markdown}</textarea>
    <article id="renderedMarkdown" class="markdown-body">
    </article>
</body>

</html>
