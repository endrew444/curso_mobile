plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services") // CRÍTICO: Plugin do Google Services
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.sa_registro"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.sa_registro"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// ⚠️ BLOCO CRÍTICO: Dependências para Firebase e outros plugins
dependencies {
    // Importa o Firebase BoM (Bill of Materials) para gerenciar as versões
    // Se você souber a versão exata que está usando, coloque ela aqui.
    implementation(platform("com.google.firebase:firebase-bom:32.7.0")) 

    // Adiciona as bibliotecas do Firebase que você está usando (Auth, Core, Firestore, etc.)
    implementation("com.google.firebase:firebase-analytics") 
    implementation("com.google.firebase:firebase-auth") 
    implementation("com.google.firebase:firebase-firestore") 
    
    // Adicione esta linha se estiver usando o plugin `local_auth`
    implementation("androidx.biometric:biometric:1.1.0")
    
    // As dependências padrão do Flutter para plugins
    // Seus plugins como geolocator, local_auth, etc., usarão as implementações corretas
}


flutter {
    source = "../.."
}