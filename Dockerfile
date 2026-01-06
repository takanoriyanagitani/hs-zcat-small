FROM haskell:9.12.2-slim-bookworm AS builder
RUN echo cabal update date: 2026-01-05
RUN cabal update --verbose=2

WORKDIR /hs-zcat-small
COPY --link ./hs-zcat-small.cabal ./
RUN cabal update
RUN cabal build --only-dependencies
COPY --link ./app/ ./app/
COPY --link ./src/ ./src/
RUN cabal build
RUN cp $( cabal list-bin hs-zcat-small | fgrep --max-count=1 hs-zcat-small ) /usr/local/bin/
RUN which hs-zcat-small
RUN printf helo | gzip --fast | hs-zcat-small | grep '^helo$'

FROM debian:bookworm-slim
COPY --link --from=builder /usr/local/bin/hs-zcat-small /usr/local/bin/

CMD ["/usr/local/bin/hs-zcat-small"]
