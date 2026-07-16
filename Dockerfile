ARG PAPERLESS_VERSION=latest
FROM ghcr.io/paperless-ngx/paperless-ngx:${PAPERLESS_VERSION}

# Re-declare after FROM: an ARG before FROM is only in scope for the FROM line itself.
ARG PAPERLESS_VERSION

LABEL org.opencontainers.image.source="https://github.com/water1309/paperless-ngx-nl"
LABEL org.opencontainers.image.description="paperless-ngx with Dutch (nld) tesseract OCR data"
LABEL nl.vanwaardenberg.upstream-version="${PAPERLESS_VERSION}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    tesseract-ocr-nld \
    && rm -rf /var/lib/apt/lists/*
