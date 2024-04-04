# Use an official Alpine Linux as a base image
FROM --platform=linux/arm/v7 alpine:latest

# Update package lists and install necessary packages
RUN apk add neovim
