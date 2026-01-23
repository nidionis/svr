cat gitea_deploy.sh 
#!/bin/bash
set -e

# Variables
GITEA_VERSION=1.21.11
USER_NAME=gitea
GITEA_PORT=9090
DATA_DIR=/opt/gitea

# Installer Docker si nécessaire
if ! command -v docker >/dev/null; then
  apt update
  apt install -y docker.io
  systemctl enable docker
  systemctl start docker
fi

# Créer dossier de données
mkdir -p ${DATA_DIR}/{data,config}

# Lancer Gitea (http://<ip>:9090)
docker run -d --name gitea \
  -p ${GITEA_PORT}:3000 \
  -p 2222:22 \
  -v ${DATA_DIR}/data:/data \
  gitea/gitea:${GITEA_VERSION}

echo "----------------------------------------"
echo "✅ Gitea lancé sur http://<IP>:${GITEA_PORT}"
echo "➡️  Identifiants à créer via l'interface web"
echo "➡️  Pour SSH : port 2222 (externe), clé à ajouter via l'UI"
echo "----------------------------------------"
