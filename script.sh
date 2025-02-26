sudo systemctl stop nginx
pkill ngrok

echo "NGINX y NGROK detenidos."

RETURN_ONE=".."
APP_DIR="/var/www/html"
cd "$RETURN_ONE" || exit
cd "$APP_DIR" || exit

echo "Cambiando al directorio de la aplicación: $APP_DIR"

# Obtener últimos cambios del repositorio
git pull origin main
echo "Código actualizado desde el repositorio."

# Iniciar NGINX
sudo systemctl start nginx
echo "NGINX iniciado."

# Iniciar NGROK y obtener la URL
nohup ngrok http 80 > /dev/null 2>&1 &
sleep 5  # Esperar que NGROK inicie correctamente
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | grep -o 'https://[a-zA-Z0-9.-]*.ngrok-free.app')

echo "NGROK iniciado en: $NGROK_URL"