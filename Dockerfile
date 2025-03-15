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

# Create a non-root user in the builder stage
RUN useradd -m rustuser

# ===== 2️⃣ Final Runtime Stage =====
FROM gcr.io/distroless/cc

# Copy the compiled binary from the builder stage
COPY --from=builder /app/target/release/my_app /usr/local/bin/my_app

# Copy the non-root user information from the builder stage
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

# Set the non-root user
USER rustuser

# Expose application port
EXPOSE 8080

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/my_app"]
