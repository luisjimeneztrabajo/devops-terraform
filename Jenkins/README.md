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
1. Ve a la **Google Cloud Console** → Menú lateral → **VPC Network** → **Firewall rules**  
2. Haz clic en **Create firewall rule**  
3. Configura los campos:  
   - **Name**: `allow-jenkins-8080`  
   - **Network**: elige la misma red de tu VM (por defecto suele ser `default`)  
   - **Targets**: selecciona `All instances in the network` (o `Specified target tags` si quieres restringir solo a tu VM con un tag)  
   - **Source filter**:  
     - Acceso desde cualquier IP → `IPv4 ranges` = `0.0.0.0/0`  
     - Acceso solo desde tu PC → tu IP pública, ej: `190.45.xxx.xxx/32`  
   - **Protocols and ports**:  
     - Marca `Specified protocols and ports` → selecciona **TCP** → escribe `8080`  
4. Haz clic en **Create** ✅


# 8. Acceder a Jenkins en el navegador
# http://<EXTERNAL_IP_VM>:8080

# 9. Obtener la contraseña inicial de Jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword



# 🎯 Crear un Pipeline en Jenkins con stages dummy

## 1. Entrar a Jenkins
- Abre tu navegador e ingresa a  
  http://<IP_EXTERNA_DE_TU_VM>:8080  
- Inicia sesión con tu usuario administrador

## 2. Crear un nuevo Job
- Haz clic en "New Item"  
- Escribe el nombre: `pipeline-dummy`  
- Selecciona "Pipeline"  
- Haz clic en "OK"  

## 3. Configurar el Pipeline
- Baja hasta la sección "Pipeline"  
- En "Definition" selecciona "Pipeline script"  
- Copia y pega el siguiente código en el editor:


pipeline {
    agent any
    stages {
        stage('Preparación') {
            steps {
                echo 'Iniciando el pipeline...'
            }
        }
        stage('Compilación') {
            steps {
                echo 'Compilando el proyecto (dummy)...'
                sh 'sleep 2'
            }
        }
        stage('Pruebas') {
            steps {
                echo 'Ejecutando pruebas unitarias (dummy)...'
                sh 'sleep 2'
            }
        }
        stage('Empaquetado') {
            steps {
                echo 'Generando artefacto (dummy)...'
                sh 'sleep 2'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Desplegando en ambiente de prueba (dummy)...'
                sh 'sleep 2'
            }
        }
        stage('Finalización') {
            steps {
                echo 'Pipeline completado ✅'
            }
        }
    }
}

