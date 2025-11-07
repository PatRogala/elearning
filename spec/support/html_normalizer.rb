# This module is used to normalize HTML strings for testing purposes.
# For VCR recordings, we need to normalize the HTML strings to avoid changes in the HTML strings between runs.
module HtmlNormalizer
  module_function

  def normalize(html)
    s = html.dup

    # 1) Strip asset digests: application-<hash>.css/js → application.css/js
    # (handles propshaft/sprockets, 8–64 hex, with or without query)
    s.gsub!(%r{(/assets/[\w/-]+?)-[0-9a-f]{8,64}\.(css|js)(\?[^"'<>]*)?}, '\1.\2')

    # 2) Importmap or esbuild chunk hashes: chunk-<hash>.js → chunk.js
    s.gsub!(%r{(/assets/[\w/-]+?)-(?:[0-9a-f]{8,64})\.js}, '\1.js')

    # 3) Vite/Rollup style: .css?mtime=... or .js?v=123 → strip query
    s.gsub!(/(\.(?:css|js))\?[^"'<>]*/, '\1')

    # 4) CSRF/meta tokens (vary per run)
    s.gsub!(/(<meta[^>]+name="csrf-token"[^>]+content=")[^"]+(")/, '\1TOKEN\2')
    s.gsub!(/(<meta[^>]+name="csp-nonce"[^>]+content=")[^"]+(")/, '\1NONCE\2')

    # 5) Turbolinks/Turbo reload markers often stable but normalize anyway
    s.gsub!(/(data-turbo-track=)"reload"/, '\1"reload"')

    # 6) SRI integrity hashes (if you have them)
    s.gsub!(%r{(integrity=")sha\d+-[A-Za-z0-9+/=]+(")}, '\1INTEGRITY\2')

    # 7) Timestamps in comments or build IDs
    s.gsub!(/Build: \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/, "Build: YYYY-MM-DD HH:MM:SS")

    s
  end
end
