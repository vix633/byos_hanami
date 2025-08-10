# Terminus - Railway Deployment Guide

This is a Ruby/Hanami application that can be deployed to Railway with PostgreSQL.

## Quick Deploy to Railway

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/terminus)

## Manual Railway Deployment

1. **Fork this repository** to your GitHub account

2. **Create a new Railway project**:
   - Go to [Railway](https://railway.app)
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose your forked repository

3. **Add PostgreSQL database**:
   - In your Railway project dashboard
   - Click "New Service"
   - Select "Database" → "PostgreSQL"

4. **Configure environment variables**:
   Railway will automatically set `DATABASE_URL`, but you may want to customize:
   - `HANAMI_ENV=production`
   - `RACK_ENV=production`
   - `API_URI` (optional - will auto-detect Railway domain)
   - `FIRMWARE_POLLER=true` (optional)
   - `MODEL_POLLER=true` (optional)
   - `SCREEN_POLLER=true` (optional)

5. **Deploy**:
   - Railway will automatically build and deploy your application
   - The health check endpoint `/up` will be used to verify deployment

## Local Development

```bash
git clone <your-fork>
cd terminus
bin/setup
overmind start --port-step 10 --procfile Procfile.dev --can-die assets,migrate
```

## Features

- **Auto-provisioning**: Devices are automatically configured
- **Dashboard**: Web interface for managing devices
- **API**: RESTful JSON API for device management
- **Image Processing**: Automatic image conversion for TRMNL devices
- **Playlists**: Organize and schedule content
- **Background Jobs**: Automatic firmware and content updates

## Environment Variables

- `DATABASE_URL`: PostgreSQL connection string (auto-set by Railway)
- `API_URI`: Public URL for device connections (auto-detected)
- `HANAMI_ENV`: Application environment (production)
- `RACK_ENV`: Rack environment (production)
- `FIRMWARE_POLLER`: Enable firmware polling (default: true)
- `MODEL_POLLER`: Enable model synchronization (default: true)
- `SCREEN_POLLER`: Enable screen synchronization (default: true)

## Health Check

The application includes a health check endpoint at `/up` that Railway uses to verify the deployment is successful.

## Support

For issues related to:
- **TRMNL devices**: [TRMNL Support](https://help.usetrmnl.com)
- **This application**: [GitHub Issues](https://github.com/usetrmnl/byos_hanami/issues)
- **Railway deployment**: [Railway Docs](https://docs.railway.app)