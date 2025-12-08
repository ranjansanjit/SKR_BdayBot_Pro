#!/bin/bash

echo "🚀 Starting SKR Birthday Bot Project..."

# --- BACKEND ---
echo "🔧 Starting Backend..."
cd backend
npm install
npm start &
BACKEND_PID=$!

# --- FRONTEND ---
echo "🎨 Starting Frontend..."
cd ../frontend
npm install
npm start &
FRONTEND_PID=$!

echo "✅ Both Frontend & Backend Started Successfully!"
echo "➡ Backend: http://localhost:3000"
echo "➡ Frontend: http://localhost:3001"

wait $BACKEND_PID
wait $FRONTEND_PID
