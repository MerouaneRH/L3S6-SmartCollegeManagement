# Smart College Management 🏫

**Smart College Management** est une **application mobile** innovante développé en 2024 pour la gestion des établissements éducatifs, développée dans le cadre d'un **projet pour l'obtention du diplôme de licence en Informatique**. Ce projet a été réalisé par **MAMCHA Mohammed Rayene**, **KERBOUA Abdellah**, **SARI Mohammed El-Mehdi**, et **RAHMOUN Merouane**.

---

## Fonctionnalités Clés ✨

- **🗑️ Gestion des Poubelles** : Surveillance en temps réel du niveau des poubelles avec notifications lorsque celles-ci sont pleines.
- **💡 Contrôle de l'Éclairage** : Allumage et extinction des lumières à distance via l'application mobile.
- **🎫 Système de Présence** : Vérification de la présence des étudiants via des cartes RFID.
- **📍 Carte Interactive** : Navigation simplifiée sur le campus avec localisation GPS des salles et zones.

---

## Démonstration 🎥

| **Poubelles** | **Éclairage** | **Présence** |
|---------------|---------------|--------------|
| ![Poubelles](https://github.com/user-attachments/assets/682a9c55-df8f-4832-8514-386fa78650b7) | ![Éclairage](https://github.com/user-attachments/assets/2f178869-f4a1-49c3-aca6-b44b2c214a69) | ![Présence](https://github.com/user-attachments/assets/7536dc53-d890-4296-84da-c105e00e1397) |


---

## Technologies Utilisées 

- **Flutter** : Pour le développement de l'application mobile (Android et iOS).
- **Firebase** : Pour la gestion des données en temps réel.
- **Arduino** : Pour la gestion des capteurs IoT (poubelles, lumières, RFID).

---
### Liste Complète des Composants

- **Capteur à Ultrasons HC-SR04** : Pour détecter le niveau des poubelles.
- **WeMos D1 R2 WiFi (ESP8266)** : Pour connecter les capteurs à Internet via Wi-Fi.
- **Câbles Jumper Male-Femelle** : Pour connecter les composants entre eux.
- **Module RFID RC522** : Pour lire les cartes RFID des étudiants.
- **Breadboard** : Pour faciliter les connexions entre les composants.
- **Relais déclencheur** : Pour contrôler l'allumage et l'extinction des lampes.
- **Lampes** : Pour simuler l'éclairage des salles.

---

## Installation

### 1. **Configurer Firebase (Backend)**

Firebase est utilisé pour gérer les données en temps réel (comme les notifications de poubelles pleines, l'état des lumières, etc.). Voici comment le configurer :

1. Va sur la [Firebase Console](https://console.firebase.google.com/) et crée un nouveau projet.
2. Ajoute une application Android/iOS à ton projet Firebase.
3. Télécharge le fichier de configuration :
   - Pour Android : `google-services.json`
   - Pour iOS : `GoogleService-Info.plist`
4. Place le fichier de configuration dans le dossier approprié de ton projet Flutter :
   - Pour Android : `android/app/`
   - Pour iOS : `ios/Runner/`
5. Active les services Firebase nécessaires :
   - **Firestore** : Pour la base de données.
   - **Authentication** : Pour la gestion des utilisateurs.

---

### 2. **Programmer les Capteurs IoT (Arduino)**

Les capteurs IoT (poubelles, lumières, RFID) sont programmés avec Arduino. Voici comment les configurer :

1. Télécharge et installe [Arduino IDE](https://www.arduino.cc/en/software).
2. Connecte tes capteurs (poubelles, lumières, RFID) à une carte Arduino.
3. Ouvre le code Arduino fourni dans le dossier `arduino/` du projet.
4. Téléverse le code sur ta carte Arduino.
5. Assure-toi que les capteurs communiquent avec l'application via Wi-Fi ou Bluetooth.

---

### 3. **Installer et Lancer l'Application Mobile (Flutter)**

L'application mobile est développée avec Flutter. Voici comment l'installer et la lancer :

1. **Installer Flutter** :
   - Si tu n'as pas encore Flutter, suis le guide d'installation officiel : [Guide d'installation de Flutter](https://flutter.dev/docs/get-started/install).

2. **Cloner le Projet** :
   - Ouvre un terminal et exécute la commande suivante pour cloner le dépôt GitHub :
     ```bash
     git clone https://github.com/votre-utilisateur/smart-college-management.git
     ```
   - Accède au dossier du projet :
     ```bash
     cd smart-college-management
     ```

3. **Installer les Dépendances** :
   - Exécute la commande suivante pour installer les dépendances du projet :
     ```bash
     flutter pub get
     ```

4. **Lancer l'Application** :
   - Connecte un appareil Android/iOS ou utilise un émulateur.
   - Exécute la commande suivante pour lancer l'application :
     ```bash
     flutter run
     ```

---

## Équipe

- **MAMCHA Mohammed Rayene**
- **KERBOUA Abdellah**
- **SARI Mohammed El-Mehdi**
- **RAHMOUN Merouane**

---
