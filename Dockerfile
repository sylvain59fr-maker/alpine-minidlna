# Utiliser Alpine comme image de base
FROM alpine:3

# Installer minidlna et curl
RUN apk add --no-cache minidlna curl

# Augmenter la limite de inotify pour éviter les avertissements
RUN echo "fs.inotify.max_user_watches=524288" > /etc/sysctl.conf && sysctl -p

# Exposer les ports nécessaires (commenté pour éviter les conflits, vous pouvez décommenter si nécessaire)
EXPOSE 8200
EXPOSE 1900/udp

# Définir le point d'entrée pour démarrer le serveur MiniDLNA
ENTRYPOINT ["/usr/sbin/minidlnad", "-S", "-r"]

# Healthcheck : vérifier que le serveur est en ligne sur le port 8200
HEALTHCHECK --interval=60s --timeout=10s --retries=6 \
  CMD curl --silent --fail 127.0.0.1:8200 || exit 1
