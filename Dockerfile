# Stage 1: build the Rust binary
FROM rust:1-slim AS build
WORKDIR /app
COPY Cargo.toml Cargo.lock* ./
COPY src ./src
RUN cargo build --release

# Stage 2: small image that only runs it
FROM debian:bookworm-slim
WORKDIR /app
COPY --from=build /app/target/release/guidance ./guidance
COPY lessons ./lessons
COPY static ./static
ENV PORT=8080
EXPOSE 8080
CMD ["./guidance"]
