FROM nginx:alpine

# Set working directory inside container
WORKDIR /usr/share/nginx/html

# Copy frontend files (index.html, frontend.js, CSS, etc.)
COPY . .

# Expose port 3000
EXPOSE 5000

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

