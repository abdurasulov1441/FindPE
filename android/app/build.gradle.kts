plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // Google Services для Firebase
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "uz.find.pe"
    compileSdk = flutter.compileSdkVersion

    ndkVersion = "27.0.12077973" // Если 27.0.12077973 не работает, используй эту

    compileOptions {
        isCoreLibraryDesugaringEnabled = true // ✅ Включаем coreLibraryDesugaring
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "uz.find.pe"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // ✅ Добавляем поддержку разных архитектур
        ndk {
            abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a", "x86", "x86_64"))
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    externalNativeBuild {
        cmake {
            version = "3.22.1"
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ Правильный способ добавления coreLibraryDesugaring
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.3")

    implementation("androidx.core:core-ktx:1.9.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
}
