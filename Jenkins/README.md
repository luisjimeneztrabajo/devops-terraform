# 🚀 Instalación y Configuración de Jenkins en Google Compute Engine (Ubuntu LTS)

Esta guía describe cómo instalar y configurar **Jenkins** en una máquina virtual con **Ubuntu LTS** en **Google Compute Engine**, y cómo crear un pipeline de prueba con un "Hola Mundo".

---

## 🔹 Paso a paso

```bash
# 1. Conectarse a la VM
gcloud compute ssh <NOMBRE_DE_TU_VM> --zone <ZONA>

# 2. Actualizar el sistema
sudo apt update && sudo apt upgrade -y

# 3. Instalar Java (requisito de Jenkins)
sudo apt install openjdk-17-jdk -y
java -version

# 4. Agregar el repositorio oficial de Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update

# 5. Instalar Jenkins
sudo apt install jenkins -y

# 6. Iniciar y habilitar Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
systemctl status jenkins

# 7. Abrir el puerto en Google Cloud (hacer desde la consola web)
# VPC Network > Firewall rules > Create rule
# Permitir tráfico TCP en el puerto 8080 (origen: tu IP o 0.0.0.0/0)

# 8. Acceder a Jenkins en el navegador
# http://<EXTERNAL_IP_VM>:8080

# 9. Obtener la contraseña inicial de Jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
