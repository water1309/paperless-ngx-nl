ARG PAPERLESS_VERSION=latest
FROM ghcr.io/paperless-ngx/paperless-ngx:${PAPERLESS_VERSION}

# Re-declare after FROM: an ARG before FROM is only in scope for the FROM line itself.
ARG PAPERLESS_VERSION

LABEL org.opencontainers.image.source="https://github.com/water1309/paperless-ngx-nl"
LABEL org.opencontainers.image.description="paperless-ngx with Dutch (nld) tesseract OCR data"
LABEL nl.vanwaardenberg.upstream-version="${PAPERLESS_VERSION}"

# apt-get upgrade pulls in Debian's own security patches for OS packages
# regardless of when upstream paperless-ngx last rebuilt its base image
# (found 2026-09-13: 25 CRITICAL CVEs across imagemagick/glib/mbedcrypto/
# perl/libraw/nltk were all inherited from the base image's OS layer).
# NOTE (2026-09-13): verified via a rebuild that apt-get upgrade currently
# finds 0 upgradable packages for imagemagick/glib/mbedcrypto/perl/libraw —
# Debian's trixie-security repo has not published the fixed versions yet.
# Keep this RUN so the fix applies automatically the moment they land.
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    tesseract-ocr-nld \
    && rm -rf /var/lib/apt/lists/* \
    && python3 -m pip install --no-cache-dir --upgrade nltk   # CVE-2026-79657/79675, fix already on PyPI
