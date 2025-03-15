# ===== 1️⃣ Build Stage =====
FROM rust:1.75 as builder

# Set working directory
WORKDIR /app

# Cache dependencies to optimize builds
COPY zumo-project/Cargo.toml zumo-project/Cargo.lock ./
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release && rm -rf src target/release/deps

# Copy source code and build the app
COPY zumo-project .
RUN cargo build --release

# ===== 2️⃣ Final Runtime Stage =====
FROM gcr.io/distroless/cc

# Set a non-root user for security
RUN useradd -m rustuser
USER rustuser

# Copy the compiled binary from the builder stage
COPY --from=builder /app/target/release/my_app /

# Expose application port (modify if necessary)
EXPOSE 8080

# Set entrypoint
CMD ["/my_app"]
