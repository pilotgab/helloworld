# ===== 1️⃣ Build Stage =====
FROM rust:1.85 as builder

# Set working directory
WORKDIR /app

# Cache dependencies to optimize builds
COPY zumo-project/Cargo.toml zumo-project/Cargo.lock ./
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release && rm -rf src target/release/deps

# Copy source code and build the app
COPY zumo-project .
RUN cargo build --release

# Set a non-root user for security
RUN useradd -m appuser

# ===== 2️⃣ Final Runtime Stage =====
FROM gcr.io/distroless/cc

# Copy the compiled binary from the builder stage
COPY --from=builder /app/target/release/zumo-project /usr/local/bin/zumo-project

# Copy the non-root user information from the builder stage
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

# Set the non-root user
USER appuser

# Expose application port (modify if necessary)
EXPOSE 8080

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/zumo-project"]
