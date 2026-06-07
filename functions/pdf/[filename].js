export async function onRequest(context) {
  const { request, env, params } = context;
  const filename = params.filename;

  if (!filename) {
    return new Response("Missing filename. Use: /pdf/filename.pdf", { status: 400 });
  }

  // Step 1: Try serving from Pages static files
  try {
    var staticUrl = new URL(request.url);
    staticUrl.pathname = "/" + encodeURI(filename);
    var staticRes = await env.ASSETS.fetch(new Request(staticUrl, request));

    if (staticRes.ok || staticRes.status === 206) {
      var hdrs = {
        "Content-Type": "application/pdf",
        "Content-Disposition": 'inline; filename="' + filename + '"',
        "Cache-Control": "public, max-age=14400",
        "Accept-Ranges": "bytes",
      };
      if (staticRes.headers.has("content-length")) {
        hdrs["Content-Length"] = staticRes.headers.get("content-length");
      }
      return new Response(staticRes.body, { status: staticRes.status, headers: hdrs });
    }
  } catch (_) {}

  // Step 2: Try GitHub (for files over 25MB)
  var user = env.GITHUB_USER;
  var repo = env.GITHUB_REPO;
  if (user && repo) {
    var path = env.GITHUB_PATH || "";
    var branch = env.GITHUB_BRANCH || "main";
    var pdfUrl = "https://raw.githubusercontent.com/" + user + "/" + repo + "/" + branch + (path ? "/" + path : "") + "/" + encodeURI(filename);
    var reqHdrs = {};
    if (request.headers.has("range")) reqHdrs["Range"] = request.headers.get("range");

    try {
      var ghRes = await fetch(pdfUrl, { headers: reqHdrs });
      if (ghRes.ok || ghRes.status === 206) {
        var hdrs2 = {
          "Content-Type": "application/pdf",
          "Content-Disposition": 'inline; filename="' + filename + '"',
          "Cache-Control": "public, max-age=3600",
          "Accept-Ranges": "bytes",
        };
        for (var h of ["content-range", "content-length"]) {
          if (ghRes.headers.has(h)) hdrs2[h] = ghRes.headers.get(h);
        }
        return new Response(ghRes.body, { status: ghRes.status, headers: hdrs2 });
      }
    } catch (_) {}
  }

  return new Response("PDF not found", { status: 404 });
}
