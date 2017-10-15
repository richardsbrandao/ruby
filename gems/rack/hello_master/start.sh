fuser -k 3000/tcp
rackup --port 3000 -Ilib -D -E development -o 0.0.0.0
