#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="RotaInteligenteIA"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

mkdir -p gradle/wrapper \
  app/src/main/java/com/example/data/local \
  app/src/main/java/com/example/data/preferences \
  app/src/main/java/com/example/domain \
  app/src/main/java/com/example/service \
  app/src/main/java/com/example/ui/components \
  app/src/main/java/com/example/ui/screens \
  app/src/main/java/com/example/ui/theme \
  app/src/main/res/drawable \
  app/src/main/res/mipmap-anydpi-v26 \
  app/src/main/res/values \
  app/src/main/res/xml \
  app/src/test/java/com/example

cat << 'EOF' > .env.example
# GEMINI_API_KEY: Opcional (app 100% nativo sem dependencia de LLM externo)
EOF

cat << 'EOF' > metadata.json
{
  "name": "Rota Inteligente IA",
  "description": "Assistente nativo para entregadores Mob Lets em Montes Claros - MG com Acessibilidade, OCR ML Kit, rota completa em 4 etapas, semáforo R$/km e janela flutuante.",
  "requestFramePermissions": [],
  "majorCapabilities": ["MAJOR_CAPABILITY_SERVER_SIDE_GEMINI_API"]
}
EOF

cat << 'EOF' > settings.gradle.kts
pluginManagement {
  repositories {
    google {
      content {
        includeGroupByRegex("com\\.android.*")
        includeGroupByRegex("com\\.google.*")
        includeGroupByRegex("androidx.*")
      }
    }
    mavenCentral()
    gradlePluginPortal()
  }
}

plugins { id("org.gradle.toolchains.foojay-resolver-convention") version "1.0.0" }

dependencyResolutionManagement {
  repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
  repositories {
    google()
    mavenCentral()
  }
}

rootProject.name = "Rota Inteligente IA"

include(":app")
EOF

cat << 'EOF' > build.gradle.kts
plugins {
  alias(libs.plugins.android.application) apply false
  alias(libs.plugins.kotlin.compose) apply false
  alias(libs.plugins.google.devtools.ksp) apply false
  alias(libs.plugins.secrets) apply false
  alias(libs.plugins.google.services) apply false
  alias(libs.plugins.kotlin.serialization) apply false
}
EOF

cat << 'EOF' > gradle.properties
org.gradle.jvmargs=-Xmx4g -Dfile.encoding=UTF-8
org.gradle.parallel=true
kotlin.code.style=official
android.nonTransitiveRClass=true
org.gradle.caching=true
org.gradle.configuration-cache=true
org.gradle.workers.max=4
kotlin.compiler.execution.strategy=in-process
googleServices.missing.passthrough=true
EOF

cat << 'EOF' > gradle/wrapper/gradle-wrapper.properties
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-9.3.1-bin.zip
networkTimeout=10000
validateDistributionUrl=true
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
EOF

cat << 'EOF' > gradle/libs.versions.toml
[versions]
agp = "9.1.1"
coreKtx = "1.18.0"
junit = "4.13.2"
junitVersion = "1.3.0"
espressoCore = "3.7.0"
lifecycleRuntimeKtx = "2.8.7"
lifecycleViewmodelCompose = "2.8.7"
lifecycleRuntimeCompose = "2.8.7"
activityCompose = "1.10.1"
kotlin = "2.4.21"
composeBom = "2024.09.00"
googleDevtoolsKsp = "2.3.5"
navigationCompose = "2.8.9"
roomRuntime = "2.7.0"
roomKtx = "2.7.0"
roomCompiler = "2.7.0"
kotlinxCoroutinesTest = "1.10.2"
core = "1.6.1"
runner = "1.6.2"
retrofit = "2.12.0"
converterMoshi = "2.12.0"
kotlinxCoroutinesAndroid = "1.10.2"
kotlinxCoroutinesCore = "1.10.2"
playServicesLocation = "21.3.0"
loggingInterceptor = "4.10.0"
okhttp = "4.10.0"
moshiKotlin = "1.15.2"
moshiKotlinCodegen = "1.15.2"
datastorePreferences = "1.1.7"
robolectric = "4.16.1"
secretsGradlePlugin = "2.0.1"
googleServices = "4.5.0"
mlkitTextRecognition = "16.0.1"
kotlinxSerializationJson = "1.8.0"

[libraries]
androidx-core-ktx = { group = "androidx.core", name = "core-ktx", version.ref = "coreKtx" }
junit = { group = "junit", name = "junit", version.ref = "junit" }
androidx-junit = { group = "androidx.test.ext", name = "junit", version.ref = "junitVersion" }
androidx-espresso-core = { group = "androidx.test.espresso", name = "espresso-core", version.ref = "espressoCore" }
androidx-lifecycle-runtime-ktx = { group = "androidx.lifecycle", name = "lifecycle-runtime-ktx", version.ref = "lifecycleRuntimeKtx" }
androidx-lifecycle-viewmodel-compose = { group = "androidx.lifecycle", name = "lifecycle-viewmodel-compose", version.ref = "lifecycleViewmodelCompose" }
androidx-lifecycle-runtime-compose = { group = "androidx.lifecycle", name = "lifecycle-runtime-compose", version.ref = "lifecycleRuntimeCompose" }
androidx-activity-compose = { group = "androidx.activity", name = "activity-compose", version.ref = "activityCompose" }
androidx-compose-bom = { group = "androidx.compose", name = "compose-bom", version.ref = "composeBom" }
androidx-compose-ui = { group = "androidx.compose.ui", name = "ui" }
androidx-compose-ui-graphics = { group = "androidx.compose.ui", name = "ui-graphics" }
androidx-compose-ui-tooling = { group = "androidx.compose.ui", name = "ui-tooling" }
androidx-compose-ui-tooling-preview = { group = "androidx.compose.ui", name = "ui-tooling-preview" }
androidx-compose-ui-test-manifest = { group = "androidx.compose.ui", name = "ui-test-manifest" }
androidx-compose-ui-test-junit4 = { group = "androidx.compose.ui", name = "ui-test-junit4" }
androidx-navigation-compose = { group = "androidx.navigation", name = "navigation-compose", version.ref = "navigationCompose" }
androidx-room-runtime = { group = "androidx.room", name = "room-runtime", version.ref = "roomRuntime" }
androidx-room-ktx = { group = "androidx.room", name = "room-ktx", version.ref = "roomKtx" }
androidx-room-compiler = { group = "androidx.room", name = "room-compiler", version.ref = "roomCompiler" }
kotlinx-coroutines-test = { group = "org.jetbrains.kotlinx", name = "kotlinx-coroutines-test", version.ref = "kotlinxCoroutinesTest" }
androidx-core = { group = "androidx.test", name = "core", version.ref = "core" }
androidx-runner = { group = "androidx.test", name = "runner", version.ref = "runner" }
androidx-compose-material3 = { group = "androidx.compose.material3", name = "material3" }
androidx-compose-material-icons-core = { group = "androidx.compose.material", name = "material-icons-core" }
androidx-compose-material-icons-extended = { group = "androidx.compose.material", name = "material-icons-extended" }
retrofit = { group = "com.squareup.retrofit2", name = "retrofit", version.ref = "retrofit" }
converter-moshi = { group = "com.squareup.retrofit2", name = "converter-moshi", version.ref = "converterMoshi" }
kotlinx-coroutines-android = { group = "org.jetbrains.kotlinx", name = "kotlinx-coroutines-android", version.ref = "kotlinxCoroutinesAndroid" }
kotlinx-coroutines-core = { group = "org.jetbrains.kotlinx", name = "kotlinx-coroutines-core", version.ref = "kotlinxCoroutinesCore" }
play-services-location = { group = "com.google.android.gms", name = "play-services-location", version.ref = "playServicesLocation" }
logging-interceptor = { group = "com.squareup.okhttp3", name = "logging-interceptor", version.ref = "loggingInterceptor" }
okhttp = { group = "com.squareup.okhttp3", name = "okhttp", version.ref = "okhttp" }
moshi-kotlin = { group = "com.squareup.moshi", name = "moshi-kotlin", version.ref = "moshiKotlin" }
moshi-kotlin-codegen = { group = "com.squareup.moshi", name = "moshi-kotlin-codegen", version.ref = "moshiKotlinCodegen" }
androidx-datastore-preferences = { group = "androidx.datastore", name = "datastore-preferences", version.ref = "datastorePreferences" }
robolectric = { group = "org.robolectric", name = "robolectric", version.ref = "robolectric" }
mlkit-text-recognition = { group = "com.google.mlkit", name = "text-recognition", version.ref = "mlkitTextRecognition" }
kotlinx-serialization-json = { group = "org.jetbrains.kotlinx", name = "kotlinx-serialization-json", version.ref = "kotlinxSerializationJson" }

[plugins]
android-application = { id = "com.android.application", version.ref = "agp" }
kotlin-compose = { id = "org.jetbrains.kotlin.plugin.compose", version.ref = "kotlin" }
google-devtools-ksp = { id = "com.google.devtools.ksp", version.ref = "googleDevtoolsKsp" }
secrets = { id = "com.google.android.libraries.mapsplatform.secrets-gradle-plugin", version.ref = "secretsGradlePlugin" }
google-services = { id = "com.google.gms.google-services", version.ref = "googleServices" }
kotlin-serialization = { id = "org.jetbrains.kotlin.plugin.serialization", version.ref = "kotlin" }
EOF

cat << 'EOF' > app/proguard-rules.pro
# Regras padrão de otimização
EOF

cat << 'EOF' > app/build.gradle.kts
import com.google.gms.googleservices.GoogleServicesPlugin.MissingGoogleServicesStrategy

plugins {
  alias(libs.plugins.android.application)
  alias(libs.plugins.kotlin.compose)
  alias(libs.plugins.google.devtools.ksp)
  alias(libs.plugins.secrets)
  alias(libs.plugins.google.services)
  alias(libs.plugins.kotlin.serialization)
}

android {
  namespace = "com.example"
  compileSdk { version = release(36) { minorApiLevel = 1 } }

  defaultConfig {
    applicationId = "com.aistudio.rotainteligente.mocvkw"
    minSdk = 24
    targetSdk = 36
    versionCode = 1
    versionName = "1.0"
    testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
  }

  signingConfigs {
    create("debugConfig") {
      storeFile = file("${rootDir}/debug.keystore")
      storePassword = "android"
      keyAlias = "androiddebugkey"
      keyPassword = "android"
    }
  }

  buildTypes {
    release {
      isCrunchPngs = false
      isMinifyEnabled = false
      proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
    }
    debug {
      signingConfig = signingConfigs.getByName("debugConfig")
    }
  }
  compileOptions {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
  }
  buildFeatures {
    compose = true
    buildConfig = true
  }
  testOptions { unitTests { isIncludeAndroidResources = true } }
}

secrets {
  propertiesFileName = ".env"
  defaultPropertiesFileName = ".env.example"
}

googleServices { missingGoogleServicesStrategy = MissingGoogleServicesStrategy.WARN }

dependencies {
  implementation(platform(libs.androidx.compose.bom))
  implementation(libs.androidx.activity.compose)
  implementation(libs.androidx.compose.material.icons.core)
  implementation(libs.androidx.compose.material.icons.extended)
  implementation(libs.androidx.compose.material3)
  implementation(libs.androidx.compose.ui)
  implementation(libs.androidx.compose.ui.graphics)
  implementation(libs.androidx.compose.ui.tooling.preview)
  implementation(libs.androidx.core.ktx)
  implementation(libs.androidx.datastore.preferences)
  implementation(libs.androidx.lifecycle.runtime.compose)
  implementation(libs.androidx.lifecycle.runtime.ktx)
  implementation(libs.androidx.lifecycle.viewmodel.compose)
  implementation(libs.androidx.navigation.compose)
  implementation(libs.androidx.room.ktx)
  implementation(libs.androidx.room.runtime)
  implementation(libs.converter.moshi)
  implementation(libs.kotlinx.coroutines.android)
  implementation(libs.kotlinx.coroutines.core)
  implementation(libs.kotlinx.serialization.json)
  implementation(libs.logging.interceptor)
  implementation(libs.mlkit.text.recognition)
  implementation(libs.moshi.kotlin)
  implementation(libs.okhttp)
  implementation(libs.play.services.location)
  implementation(libs.retrofit)
  testImplementation(libs.androidx.compose.ui.test.junit4)
  testImplementation(libs.androidx.core)
  testImplementation(libs.androidx.junit)
  testImplementation(libs.junit)
  testImplementation(libs.kotlinx.coroutines.test)
  testImplementation(libs.robolectric)
  debugImplementation(libs.androidx.compose.ui.test.manifest)
  debugImplementation(libs.androidx.compose.ui.tooling)
  "ksp"(libs.androidx.room.compiler)
  "ksp"(libs.moshi.kotlin.codegen)
}
EOF

cat << 'EOF' > app/src/main/AndroidManifest.xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_SPECIAL_USE" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

    <application
        android:name=".RotaInteligenteApp"
        android:allowBackup="true"
        android:dataExtractionRules="@xml/data_extraction_rules"
        android:fullBackupContent="@xml/backup_rules"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.RotaInteligente">

        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:label="@string/app_name"
            android:theme="@style/Theme.RotaInteligente">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

        <service
            android:name=".service.MobLetsAccessibilityService"
            android:exported="true"
            android:label="@string/accessibility_service_label"
            android:permission="android.permission.BIND_ACCESSIBILITY_SERVICE">
            <intent-filter>
                <action android:name="android.accessibilityservice.AccessibilityService" />
            </intent-filter>
            <meta-data
                android:name="android.accessibilityservice"
                android:resource="@xml/accessibility_service_config" />
        </service>

        <service
            android:name=".service.FloatingOverlayService"
            android:enabled="true"
            android:exported="false"
            android:foregroundServiceType="specialUse">
            <property
                android:name="android.app.PROPERTY_SPECIAL_USE_FGS_SUBTYPE"
                android:value="Floating delivery offer decision HUD displaying R$/km profitability and Montes Claros route safety over delivery apps without automating taps" />
        </service>
    </application>

</manifest>
EOF

cat << 'EOF' > app/src/main/res/values/strings.xml
<resources>
    <string name="app_name">Rota Inteligente IA</string>
    <string name="accessibility_service_label">Rota Inteligente IA • Leitor Mob Lets</string>
    <string name="accessibility_service_description">Detecta ofertas de entrega exibidas na tela (preço, loja de retirada e endereço do cliente) usando acessibilidade ou fallback OCR para calcular km totais, R$/km e alertas de bairro. Nunca aceita nem recusa corridas automaticamente.</string>
    <string name="overlay_notification_channel_name">Monitoramento Flutuante</string>
    <string name="overlay_notification_channel_desc">Mantém o painel flutuante de análise de corridas ativo sobre o Mob Lets</string>
    <string name="overlay_notification_title">Rota Inteligente IA ativa</string>
    <string name="overlay_notification_text">Monitorando ofertas • Meta mínima R$ 1,90/km • Montes Claros</string>
</resources>
EOF

cat << 'EOF' > app/src/main/res/values/colors.xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="black">#FF000000</color>
    <color name="white">#FFFFFFFF</color>
</resources>
EOF

cat << 'EOF' > app/src/main/res/values/themes.xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Theme.RotaInteligente" parent="android:Theme.DeviceDefault.NoActionBar" />
</resources>
EOF

cat << 'EOF' > app/src/main/res/xml/accessibility_service_config.xml
<?xml version="1.0" encoding="utf-8"?>
<accessibility-service xmlns:android="http://schemas.android.com/apk/res/android"
    android:accessibilityEventTypes="typeWindowStateChanged|typeWindowContentChanged"
    android:accessibilityFeedbackType="feedbackGeneric"
    android:accessibilityFlags="flagDefault|flagRetrieveInteractiveWindows|flagReportViewIds|flagIncludeNotImportantViews"
    android:canRetrieveWindowContent="true"
    android:canTakeScreenshot="true"
    android:description="@string/accessibility_service_description"
    android:notificationTimeout="200"
    android:settingsActivity="com.example.MainActivity" />
EOF

cat << 'EOF' > app/src/main/res/xml/backup_rules.xml
<?xml version="1.0" encoding="utf-8"?>
<full-backup-content />
EOF

cat << 'EOF' > app/src/main/res/xml/data_extraction_rules.xml
<?xml version="1.0" encoding="utf-8"?>
<data-extraction-rules>
    <cloud-backup />
</data-extraction-rules>
EOF

cat << 'EOF' > app/src/main/res/drawable/ic_launcher_background.xml
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="108dp"
    android:height="108dp"
    android:viewportWidth="108"
    android:viewportHeight="108">
    <path
        android:fillColor="#0E1E3F"
        android:pathData="M0,0h108v108h-108z" />
</vector>
EOF

cat << 'EOF' > app/src/main/res/drawable/ic_launcher_foreground.xml
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="108dp"
    android:height="108dp"
    android:viewportWidth="108"
    android:viewportHeight="108">
    <path
        android:fillColor="#10B981"
        android:pathData="M54,22C41.8,22 32,31.8 32,44c0,16.5 22,42 22,42s22,-25.5 22,-42C76,31.8 66.2,22 54,22z" />
    <path
        android:fillColor="#0E1E3F"
        android:pathData="M54,34a10,10 0 1,0 0,20a10,10 0 1,0 0,-20z" />
    <path
        android:fillColor="#38BDF8"
        android:pathData="M54,39a5,5 0 1,0 0,10a5,5 0 1,0 0,-10z" />
</vector>
EOF

cat << 'EOF' > app/src/main/res/drawable/img_route_banner.xml
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="400dp"
    android:height="180dp"
    android:viewportWidth="400"
    android:viewportHeight="180">
    <path
        android:fillColor="#0B162C"
        android:pathData="M0,0h400v180h-400z" />
    <path
        android:strokeColor="#1E3A5F"
        android:strokeWidth="2"
        android:pathData="M0,40 L400,40 M0,90 L400,90 M0,140 L400,140 M80,0 L80,180 M200,0 L200,180 M320,0 L320,180" />
    <path
        android:strokeColor="#38BDF8"
        android:strokeWidth="4"
        android:pathData="M40,140 Q130,40 210,100 T360,45" />
    <path
        android:fillColor="#10B981"
        android:pathData="M210,92a8,8 0 1,0 0,16a8,8 0 1,0 0,-16z" />
    <path
        android:fillColor="#F59E0B"
        android:pathData="M360,37a8,8 0 1,0 0,16a8,8 0 1,0 0,-16z" />
</vector>
EOF

cat << 'EOF' > app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@drawable/ic_launcher_background" />
    <foreground android:drawable="@drawable/ic_launcher_foreground" />
</adaptive-icon>
EOF

cat << 'EOF' > app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@drawable/ic_launcher_background" />
    <foreground android:drawable="@drawable/ic_launcher_foreground" />
</adaptive-icon>
EOF

cat << 'EOF' > app/src/main/java/com/example/data/local/Entities.kt
package com.example.data.local

import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey

enum class TrafficLightDecision {
    GREEN,
    YELLOW,
    RED
}

enum class NeighborhoodStatus {
    PREFERRED,
    NEUTRAL,
    AVOIDED
}

enum class OfferCaptureSource {
    ACCESSIBILITY,
    OCR_SCREENSHOT,
    OCR_IMAGE,
    MANUAL
}

@Entity(tableName = "analyzed_offers")
data class AnalyzedOfferEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    val timestamp: Long = System.currentTimeMillis(),
    val source: String,
    val rawSnippet: String,
    val offerPriceBrl: Double,
    val pickupAddress: String,
    val pickupNeighborhood: String,
    val customerAddress: String,
    val customerNeighborhood: String,
    val leg1CurrentToPickupKm: Double,
    val leg2PickupToCustomerKm: Double,
    val leg3CustomerToCenterKm: Double,
    val totalKm: Double,
    val earningsPerKm: Double,
    val targetPerKm: Double,
    val decision: String,
    val decisionReason: String,
    val neighborhoodAlert: String? = null,
    val routeSource: String,
    val usedGpsStart: Boolean
)

@Entity(tableName = "neighborhood_rules")
data class NeighborhoodRuleEntity(
    @PrimaryKey val name: String,
    val normalizedKey: String,
    val status: String,
    val notes: String = "",
    val isCustom: Boolean = false,
    val updatedAt: Long = System.currentTimeMillis()
)

@Entity(
    tableName = "cached_addresses",
    indices = [Index(value = ["expiresAt"])]
)
data class CachedAddressEntity(
    @PrimaryKey val normalizedQuery: String,
    val originalQuery: String,
    val latitude: Double,
    val longitude: Double,
    val resolvedNeighborhood: String,
    val resolutionSource: String,
    val createdAt: Long,
    val expiresAt: Long
)

@Entity(
    tableName = "cached_routes",
    indices = [Index(value = ["expiresAt"])]
)
data class CachedRouteEntity(
    @PrimaryKey val routeKey: String,
    val leg1Km: Double,
    val leg2Km: Double,
    val leg3Km: Double,
    val totalKm: Double,
    val routeSource: String,
    val createdAt: Long,
    val expiresAt: Long
)
EOF

cat << 'EOF' > app/src/main/java/com/example/data/local/Daos.kt
package com.example.data.local

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import kotlinx.coroutines.flow.Flow

@Dao
interface OfferDao {
    @Query("SELECT * FROM analyzed_offers ORDER BY timestamp DESC")
    fun observeAllOffers(): Flow<List<AnalyzedOfferEntity>>

    @Query("SELECT * FROM analyzed_offers ORDER BY timestamp DESC LIMIT 1")
    fun observeLatestOffer(): Flow<AnalyzedOfferEntity?>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertOffer(offer: AnalyzedOfferEntity): Long

    @Query("DELETE FROM analyzed_offers WHERE id = :id")
    suspend fun deleteOfferById(id: Long)

    @Query("DELETE FROM analyzed_offers")
    suspend fun clearAllOffers()

    @Query("DELETE FROM analyzed_offers WHERE timestamp < :cutoffTimestamp")
    suspend fun deleteOffersOlderThan(cutoffTimestamp: Long): Int

    @Query(
        "DELETE FROM analyzed_offers WHERE id NOT IN " +
            "(SELECT id FROM analyzed_offers ORDER BY timestamp DESC LIMIT :maxRows)"
    )
    suspend fun trimOffersKeepingLatest(maxRows: Int): Int
}

@Dao
interface NeighborhoodDao {
    @Query("SELECT * FROM neighborhood_rules ORDER BY CASE status WHEN 'AVOIDED' THEN 0 WHEN 'PREFERRED' THEN 1 ELSE 2 END, name ASC")
    fun observeAllRules(): Flow<List<NeighborhoodRuleEntity>>

    @Query("SELECT * FROM neighborhood_rules")
    suspend fun getAllRulesOnce(): List<NeighborhoodRuleEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun upsertRule(rule: NeighborhoodRuleEntity)

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    suspend fun insertIgnoreAll(rules: List<NeighborhoodRuleEntity>)

    @Query("UPDATE neighborhood_rules SET status = :status, notes = :notes, updatedAt = :updatedAt WHERE name = :name")
    suspend fun updateRuleStatus(name: String, status: String, notes: String, updatedAt: Long)

    @Query("DELETE FROM neighborhood_rules WHERE name = :name AND isCustom = 1")
    suspend fun deleteCustomRule(name: String)
}

@Dao
interface GeoCacheDao {
    @Query("SELECT * FROM cached_addresses WHERE normalizedQuery = :normalizedQuery LIMIT 1")
    suspend fun getAddress(normalizedQuery: String): CachedAddressEntity?

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun upsertAddress(entity: CachedAddressEntity)

    @Query("DELETE FROM cached_addresses WHERE expiresAt <= :now")
    suspend fun deleteExpiredAddresses(now: Long): Int

    @Query("SELECT COUNT(*) FROM cached_addresses WHERE expiresAt > :now")
    suspend fun countValidAddresses(now: Long): Int

    @Query(
        "DELETE FROM cached_addresses WHERE normalizedQuery NOT IN " +
            "(SELECT normalizedQuery FROM cached_addresses ORDER BY createdAt DESC LIMIT :maxRows)"
    )
    suspend fun trimAddressesKeepingLatest(maxRows: Int): Int

    @Query("DELETE FROM cached_addresses")
    suspend fun clearAllAddresses()

    @Query("SELECT * FROM cached_routes WHERE routeKey = :routeKey LIMIT 1")
    suspend fun getRoute(routeKey: String): CachedRouteEntity?

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun upsertRoute(entity: CachedRouteEntity)

    @Query("DELETE FROM cached_routes WHERE expiresAt <= :now")
    suspend fun deleteExpiredRoutes(now: Long): Int

    @Query("SELECT COUNT(*) FROM cached_routes WHERE expiresAt > :now")
    suspend fun countValidRoutes(now: Long): Int

    @Query(
        "DELETE FROM cached_routes WHERE routeKey NOT IN " +
            "(SELECT routeKey FROM cached_routes ORDER BY createdAt DESC LIMIT :maxRows)"
    )
    suspend fun trimRoutesKeepingLatest(maxRows: Int): Int

    @Query("DELETE FROM cached_routes")
    suspend fun clearAllRoutes()
}
EOF

cat << 'EOF' > app/src/main/java/com/example/data/local/AppDatabase.kt
package com.example.data.local

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.room.migration.Migration
import androidx.sqlite.db.SupportSQLiteDatabase

@Database(
    entities = [
        AnalyzedOfferEntity::class,
        NeighborhoodRuleEntity::class,
        CachedAddressEntity::class,
        CachedRouteEntity::class
    ],
    version = 2,
    exportSchema = false
)
abstract class AppDatabase : RoomDatabase() {
    abstract fun offerDao(): OfferDao
    abstract fun neighborhoodDao(): NeighborhoodDao
    abstract fun geoCacheDao(): GeoCacheDao

    companion object {
        @Volatile
        private var INSTANCE: AppDatabase? = null

        val MIGRATION_1_2: Migration = object : Migration(1, 2) {
            override fun migrate(db: SupportSQLiteDatabase) {
                db.execSQL(
                    """
                    CREATE TABLE IF NOT EXISTS `cached_addresses` (
                        `normalizedQuery` TEXT NOT NULL,
                        `originalQuery` TEXT NOT NULL,
                        `latitude` REAL NOT NULL,
                        `longitude` REAL NOT NULL,
                        `resolvedNeighborhood` TEXT NOT NULL,
                        `resolutionSource` TEXT NOT NULL,
                        `createdAt` INTEGER NOT NULL,
                        `expiresAt` INTEGER NOT NULL,
                        PRIMARY KEY(`normalizedQuery`)
                    )
                    """.trimIndent()
                )
                db.execSQL(
                    "CREATE INDEX IF NOT EXISTS `index_cached_addresses_expiresAt` ON `cached_addresses` (`expiresAt`)"
                )

                db.execSQL(
                    """
                    CREATE TABLE IF NOT EXISTS `cached_routes` (
                        `routeKey` TEXT NOT NULL,
                        `leg1Km` REAL NOT NULL,
                        `leg2Km` REAL NOT NULL,
                        `leg3Km` REAL NOT NULL,
                        `totalKm` REAL NOT NULL,
                        `routeSource` TEXT NOT NULL,
                        `createdAt` INTEGER NOT NULL,
                        `expiresAt` INTEGER NOT NULL,
                        PRIMARY KEY(`routeKey`)
                    )
                    """.trimIndent()
                )
                db.execSQL(
                    "CREATE INDEX IF NOT EXISTS `index_cached_routes_expiresAt` ON `cached_routes` (`expiresAt`)"
                )
            }
        }

        fun getInstance(context: Context): AppDatabase {
            return INSTANCE ?: synchronized(this) {
                INSTANCE ?: Room.databaseBuilder(
                    context.applicationContext,
                    AppDatabase::class.java,
                    "rota_inteligente_db"
                )
                    .addMigrations(MIGRATION_1_2)
                    .build()
                    .also { INSTANCE = it }
            }
        }
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/data/GeoCacheStore.kt
package com.example.data

import com.example.data.local.CachedAddressEntity
import com.example.data.local.CachedRouteEntity
import com.example.data.local.GeoCacheDao
import java.util.concurrent.ConcurrentHashMap

interface GeoCacheStore {
    suspend fun getValidAddress(normalizedQuery: String, now: Long = System.currentTimeMillis()): CachedAddressEntity?
    suspend fun getStaleAddress(normalizedQuery: String): CachedAddressEntity?
    suspend fun putAddress(entity: CachedAddressEntity)
    suspend fun getValidRoute(routeKey: String, now: Long = System.currentTimeMillis()): CachedRouteEntity?
    suspend fun getStaleRoute(routeKey: String): CachedRouteEntity?
    suspend fun putRoute(entity: CachedRouteEntity)
    suspend fun pruneExpired(now: Long = System.currentTimeMillis())
    suspend fun clearAll()
}

class RoomGeoCacheStore(
    private val dao: GeoCacheDao,
    private val maxAddressEntries: Int = 500,
    private val maxRouteEntries: Int = 500
) : GeoCacheStore {

    private val memoryAddressCache = ConcurrentHashMap<String, CachedAddressEntity>()
    private val memoryRouteCache = ConcurrentHashMap<String, CachedRouteEntity>()

    override suspend fun getValidAddress(normalizedQuery: String, now: Long): CachedAddressEntity? {
        val memHit = memoryAddressCache[normalizedQuery]
        if (memHit != null) {
            if (memHit.expiresAt > now) return memHit
            memoryAddressCache.remove(normalizedQuery)
        }
        val dbHit = dao.getAddress(normalizedQuery) ?: return null
        return if (dbHit.expiresAt > now) {
            memoryAddressCache[normalizedQuery] = dbHit
            dbHit
        } else {
            null
        }
    }

    override suspend fun getStaleAddress(normalizedQuery: String): CachedAddressEntity? {
        return memoryAddressCache[normalizedQuery] ?: dao.getAddress(normalizedQuery)
    }

    override suspend fun putAddress(entity: CachedAddressEntity) {
        memoryAddressCache[entity.normalizedQuery] = entity
        if (memoryAddressCache.size > maxAddressEntries) {
            memoryAddressCache.clear()
            memoryAddressCache[entity.normalizedQuery] = entity
        }
        dao.upsertAddress(entity)
    }

    override suspend fun getValidRoute(routeKey: String, now: Long): CachedRouteEntity? {
        val memHit = memoryRouteCache[routeKey]
        if (memHit != null) {
            if (memHit.expiresAt > now) return memHit
            memoryRouteCache.remove(routeKey)
        }
        val dbHit = dao.getRoute(routeKey) ?: return null
        return if (dbHit.expiresAt > now) {
            memoryRouteCache[routeKey] = dbHit
            dbHit
        } else {
            null
        }
    }

    override suspend fun getStaleRoute(routeKey: String): CachedRouteEntity? {
        return memoryRouteCache[routeKey] ?: dao.getRoute(routeKey)
    }

    override suspend fun putRoute(entity: CachedRouteEntity) {
        memoryRouteCache[entity.routeKey] = entity
        if (memoryRouteCache.size > maxRouteEntries) {
            memoryRouteCache.clear()
            memoryRouteCache[entity.routeKey] = entity
        }
        dao.upsertRoute(entity)
    }

    override suspend fun pruneExpired(now: Long) {
        memoryAddressCache.entries.removeIf { it.value.expiresAt <= now }
        memoryRouteCache.entries.removeIf { it.value.expiresAt <= now }
        dao.deleteExpiredAddresses(now)
        dao.deleteExpiredRoutes(now)
        dao.trimAddressesKeepingLatest(maxAddressEntries)
        dao.trimRoutesKeepingLatest(maxRouteEntries)
    }

    override suspend fun clearAll() {
        memoryAddressCache.clear()
        memoryRouteCache.clear()
        dao.clearAllAddresses()
        dao.clearAllRoutes()
    }
}

class InMemoryGeoCacheStore : GeoCacheStore {
    private val addresses = ConcurrentHashMap<String, CachedAddressEntity>()
    private val routes = ConcurrentHashMap<String, CachedRouteEntity>()

    override suspend fun getValidAddress(normalizedQuery: String, now: Long): CachedAddressEntity? =
        addresses[normalizedQuery]?.takeIf { it.expiresAt > now }

    override suspend fun getStaleAddress(normalizedQuery: String): CachedAddressEntity? =
        addresses[normalizedQuery]

    override suspend fun putAddress(entity: CachedAddressEntity) {
        addresses[entity.normalizedQuery] = entity
    }

    override suspend fun getValidRoute(routeKey: String, now: Long): CachedRouteEntity? =
        routes[routeKey]?.takeIf { it.expiresAt > now }

    override suspend fun getStaleRoute(routeKey: String): CachedRouteEntity? =
        routes[routeKey]

    override suspend fun putRoute(entity: CachedRouteEntity) {
        routes[entity.routeKey] = entity
    }

    override suspend fun pruneExpired(now: Long) {
        addresses.entries.removeIf { it.value.expiresAt <= now }
        routes.entries.removeIf { it.value.expiresAt <= now }
    }

    override suspend fun clearAll() {
        addresses.clear()
        routes.clear()
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/data/OfferRepository.kt
package com.example.data

import com.example.data.local.AnalyzedOfferEntity
import com.example.data.local.NeighborhoodDao
import com.example.data.local.NeighborhoodRuleEntity
import com.example.data.local.NeighborhoodStatus
import com.example.data.local.OfferDao
import com.example.domain.MontesClarosGeoCatalog
import kotlinx.coroutines.flow.Flow

class OfferRepository(
    private val offerDao: OfferDao,
    private val neighborhoodDao: NeighborhoodDao
) {
    val allOffers: Flow<List<AnalyzedOfferEntity>> = offerDao.observeAllOffers()
    val latestOffer: Flow<AnalyzedOfferEntity?> = offerDao.observeLatestOffer()
    val allNeighborhoodRules: Flow<List<NeighborhoodRuleEntity>> = neighborhoodDao.observeAllRules()

    suspend fun ensureSeededNeighborhoods() {
        neighborhoodDao.insertIgnoreAll(MontesClarosGeoCatalog.defaultRuleEntities())
    }

    suspend fun getNeighborhoodRulesOnce(): List<NeighborhoodRuleEntity> {
        ensureSeededNeighborhoods()
        return neighborhoodDao.getAllRulesOnce()
    }

    suspend fun saveAnalyzedOffer(offer: AnalyzedOfferEntity): Long {
        val insertedId = offerDao.insertOffer(offer)
        pruneOldOffers()
        return insertedId
    }

    suspend fun pruneOldOffers(
        maxAgeMs: Long = OFFER_RETENTION_MS,
        maxRows: Int = MAX_HISTORY_ROWS
    ) {
        val cutoff = System.currentTimeMillis() - maxAgeMs
        offerDao.deleteOffersOlderThan(cutoff)
        offerDao.trimOffersKeepingLatest(maxRows)
    }

    suspend fun deleteOffer(id: Long) =
        offerDao.deleteOfferById(id)

    suspend fun clearHistory() =
        offerDao.clearAllOffers()

    suspend fun updateNeighborhoodStatus(
        name: String,
        status: NeighborhoodStatus,
        notes: String = ""
    ) {
        neighborhoodDao.updateRuleStatus(
            name = name,
            status = status.name,
            notes = notes,
            updatedAt = System.currentTimeMillis()
        )
    }

    suspend fun addCustomNeighborhood(
        name: String,
        status: NeighborhoodStatus,
        notes: String
    ) {
        val trimmed = name.trim()
        if (trimmed.isBlank()) return
        neighborhoodDao.upsertRule(
            NeighborhoodRuleEntity(
                name = trimmed,
                normalizedKey = MontesClarosGeoCatalog.normalize(trimmed),
                status = status.name,
                notes = notes.trim(),
                isCustom = true,
                updatedAt = System.currentTimeMillis()
            )
        )
    }

    suspend fun deleteCustomNeighborhood(name: String) {
        neighborhoodDao.deleteCustomRule(name)
    }

    companion object {
        private const val OFFER_RETENTION_MS = 30L * 24L * 60L * 60L * 1000L
        private const val MAX_HISTORY_ROWS = 300
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/data/preferences/DriverPreferencesRepository.kt
package com.example.data.preferences

import android.content.Context
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.doublePreferencesKey
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.preferencesDataStore
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map

private val Context.dataStore by preferencesDataStore(name = "driver_settings")

data class DriverSettings(
    val minTargetPerKm: Double = 1.90,
    val ocrFallbackEnabled: Boolean = true,
    val useOsrmRoadRouting: Boolean = true,
    val autoShowOverlayOnOffer: Boolean = true,
    val strictMobLetsPackageFilter: Boolean = false,
    val cautionReturnThresholdKm: Double = 6.5
)

class DriverPreferencesRepository(private val context: Context) {

    private object Keys {
        val MIN_TARGET_PER_KM = doublePreferencesKey("min_target_per_km")
        val OCR_FALLBACK_ENABLED = booleanPreferencesKey("ocr_fallback_enabled")
        val USE_OSRM_ROAD_ROUTING = booleanPreferencesKey("use_osrm_road_routing")
        val AUTO_SHOW_OVERLAY = booleanPreferencesKey("auto_show_overlay")
        val STRICT_MOBLETS_FILTER = booleanPreferencesKey("strict_moblets_filter")
        val CAUTION_RETURN_KM = doublePreferencesKey("caution_return_km")
    }

    val settingsFlow: Flow<DriverSettings> = context.dataStore.data.map { prefs ->
        DriverSettings(
            minTargetPerKm = prefs[Keys.MIN_TARGET_PER_KM] ?: 1.90,
            ocrFallbackEnabled = prefs[Keys.OCR_FALLBACK_ENABLED] ?: true,
            useOsrmRoadRouting = prefs[Keys.USE_OSRM_ROAD_ROUTING] ?: true,
            autoShowOverlayOnOffer = prefs[Keys.AUTO_SHOW_OVERLAY] ?: true,
            strictMobLetsPackageFilter = prefs[Keys.STRICT_MOBLETS_FILTER] ?: false,
            cautionReturnThresholdKm = prefs[Keys.CAUTION_RETURN_KM] ?: 6.5
        )
    }

    suspend fun getSettingsOnce(): DriverSettings = settingsFlow.first()

    suspend fun setMinTargetPerKm(value: Double) {
        context.dataStore.edit { it[Keys.MIN_TARGET_PER_KM] = value.coerceIn(0.50, 10.0) }
    }

    suspend fun setOcrFallbackEnabled(enabled: Boolean) {
        context.dataStore.edit { it[Keys.OCR_FALLBACK_ENABLED] = enabled }
    }

    suspend fun setUseOsrmRoadRouting(enabled: Boolean) {
        context.dataStore.edit { it[Keys.USE_OSRM_ROAD_ROUTING] = enabled }
    }

    suspend fun setAutoShowOverlayOnOffer(enabled: Boolean) {
        context.dataStore.edit { it[Keys.AUTO_SHOW_OVERLAY] = enabled }
    }

    suspend fun setStrictMobLetsPackageFilter(enabled: Boolean) {
        context.dataStore.edit { it[Keys.STRICT_MOBLETS_FILTER] = enabled }
    }

    suspend fun setCautionReturnThresholdKm(km: Double) {
        context.dataStore.edit { it[Keys.CAUTION_RETURN_KM] = km.coerceIn(2.0, 20.0) }
    }
}
EOF
cat << 'EOF' > app/src/main/java/com/example/domain/MontesClarosGeoCatalog.kt
package com.example.domain

import com.example.data.local.NeighborhoodRuleEntity
import com.example.data.local.NeighborhoodStatus
import java.text.Normalizer

enum class NeighborhoodConfidence {
    HIGH,
    MEDIUM,
    LOW,
    UNIDENTIFIED
}

data class GeocoderPlaceMetadata(
    val subLocality: String? = null,
    val thoroughfare: String? = null,
    val featureName: String? = null,
    val addressLine: String? = null,
    val locality: String? = null
)

data class GeoPoint(
    val latitude: Double,
    val longitude: Double,
    val label: String = "",
    val geocoderMetadata: GeocoderPlaceMetadata? = null
)

data class KnownNeighborhood(
    val name: String,
    val latitude: Double,
    val longitude: Double,
    val defaultStatus: NeighborhoodStatus,
    val defaultNote: String = ""
)

data class NeighborhoodMatchResult(
    val name: String,
    val confidence: NeighborhoodConfidence,
    val rule: NeighborhoodRuleEntity?,
    val sourceDetail: String
)

object MontesClarosGeoCatalog {

    const val UNIDENTIFIED_NEIGHBORHOOD = "Bairro não identificado"

    val DOWNTOWN_MONTES_CLAROS = GeoPoint(
        latitude = -16.7282,
        longitude = -43.8617,
        label = "Centro de Montes Claros - MG"
    )

    const val MIN_LAT = -16.86
    const val MAX_LAT = -16.60
    const val MIN_LON = -44.00
    const val MAX_LON = -43.75

    fun isWithinMontesClarosBounds(lat: Double, lon: Double): Boolean =
        lat.isFinite() && lon.isFinite() && lat in MIN_LAT..MAX_LAT && lon in MIN_LON..MAX_LON

    fun isUnidentified(label: String): Boolean =
        label.isBlank() || label.equals(UNIDENTIFIED_NEIGHBORHOOD, ignoreCase = true)

    val knownNeighborhoods: List<KnownNeighborhood> = listOf(
        KnownNeighborhood("Centro", -16.7282, -43.8617, NeighborhoodStatus.PREFERRED, "Polo central de restaurantes e retorno rápido"),
        KnownNeighborhood("Todos os Santos", -16.7338, -43.8669, NeighborhoodStatus.PREFERRED, "Área central nobre, alta liquidez"),
        KnownNeighborhood("Melo", -16.7245, -43.8705, NeighborhoodStatus.PREFERRED, "Próximo ao Centro e Av. Dulce Sarmento"),
        KnownNeighborhood("Ibituruna", -16.7385, -43.8832, NeighborhoodStatus.PREFERRED, "Boa demanda, vias largas"),
        KnownNeighborhood("São José", -16.7210, -43.8668, NeighborhoodStatus.PREFERRED, "Acesso rápido ao Centro"),
        KnownNeighborhood("Cândida Câmara", -16.7346, -43.8732, NeighborhoodStatus.PREFERRED, "Região residencial segura"),
        KnownNeighborhood("Morada do Sol", -16.7432, -43.8775, NeighborhoodStatus.PREFERRED, "Próximo à área comercial sul"),
        KnownNeighborhood("Major Prates", -16.7458, -43.8672, NeighborhoodStatus.PREFERRED, "Grande polo gastronômico e fácil retorno"),
        KnownNeighborhood("Augusta Mota", -16.7310, -43.8768, NeighborhoodStatus.PREFERRED, "Próximo ao Montes Claros Shopping"),
        KnownNeighborhood("Jardim São Luiz", -16.7382, -43.8634, NeighborhoodStatus.PREFERRED, "Fácil acesso pela Av. Mestra Fininha"),
        KnownNeighborhood("Morada do Parque", -16.7485, -43.8738, NeighborhoodStatus.PREFERRED, "Próximo ao Parque Municipal"),
        KnownNeighborhood("Vila Guilhermina", -16.7322, -43.8626, NeighborhoodStatus.PREFERRED, "Região central tranquila"),
        KnownNeighborhood("Funcionários", -16.7315, -43.8588, NeighborhoodStatus.PREFERRED, "Vizinho ao Centro"),
        KnownNeighborhood("São Geraldo", -16.7230, -43.8608, NeighborhoodStatus.PREFERRED, "Acesso rápido ao polo central"),
        KnownNeighborhood("Jardim Brasil", -16.7164, -43.8674, NeighborhoodStatus.NEUTRAL, "Corredor da Av. Plínio Ribeiro"),
        KnownNeighborhood("Sagrada Família", -16.7224, -43.8765, NeighborhoodStatus.NEUTRAL, "Bairro residencial próximo à região oeste"),
        KnownNeighborhood("Edgar Pereira", -16.7168, -43.8602, NeighborhoodStatus.NEUTRAL, "Corredor norte central"),
        KnownNeighborhood("Canelas", -16.7524, -43.8631, NeighborhoodStatus.NEUTRAL, "Região sul intermediária"),
        KnownNeighborhood("Vila Brasília", -16.7186, -43.8512, NeighborhoodStatus.NEUTRAL, "Atenção ao trânsito em horários de pico"),
        KnownNeighborhood("Santa Rita", -16.7351, -43.8548, NeighborhoodStatus.NEUTRAL, "Próximo ao centro leste"),
        KnownNeighborhood("São Judas Tadeu", -16.7135, -43.8722, NeighborhoodStatus.NEUTRAL, "Região noroeste"),
        KnownNeighborhood("Maracanã", -16.7568, -43.8780, NeighborhoodStatus.NEUTRAL, "Extremo sul, avaliar distância de retorno"),
        KnownNeighborhood("Jardim Panorama", -16.7460, -43.8505, NeighborhoodStatus.NEUTRAL, "Região sudeste"),
        KnownNeighborhood("Cidade Nova", -16.7192, -43.8794, NeighborhoodStatus.NEUTRAL, "Próximo à saída para Juramento"),
        KnownNeighborhood("Santo Antônio", -16.7124, -43.8562, NeighborhoodStatus.NEUTRAL, "Região norte intermediária"),
        KnownNeighborhood("Lourdes", -16.7295, -43.8520, NeighborhoodStatus.NEUTRAL, "Próximo ao centro"),
        KnownNeighborhood("Esplanada", -16.7160, -43.8442, NeighborhoodStatus.NEUTRAL, "Região leste"),
        KnownNeighborhood("Vila Exposição", -16.7418, -43.8588, NeighborhoodStatus.NEUTRAL, "Próximo ao Parque de Exposições"),
        KnownNeighborhood("Santa Lúcia", -16.7478, -43.8615, NeighborhoodStatus.NEUTRAL, "Região sul próximo ao Major Prates"),
        KnownNeighborhood("Vera Cruz", -16.7392, -43.8468, NeighborhoodStatus.NEUTRAL, "Região leste intermediária"),
        KnownNeighborhood("Alcides Rabelo", -16.7068, -43.8605, NeighborhoodStatus.NEUTRAL, "Região norte"),
        KnownNeighborhood("Monte Carmelo", -16.7202, -43.8842, NeighborhoodStatus.NEUTRAL, "Região oeste"),
        KnownNeighborhood("Morrinhos", -16.7262, -43.8548, NeighborhoodStatus.NEUTRAL, "Região centro-leste"),
        KnownNeighborhood("Camilo Prates", -16.7340, -43.8452, NeighborhoodStatus.NEUTRAL, "Região leste"),
        KnownNeighborhood("Vila Mauricéia", -16.7375, -43.8698, NeighborhoodStatus.NEUTRAL, "Próximo ao Ibituruna"),
        KnownNeighborhood("Universitário", -16.7128, -43.8788, NeighborhoodStatus.NEUTRAL, "Próximo à Unimontes / Campus"),
        KnownNeighborhood("Jaraguá", -16.7088, -43.8695, NeighborhoodStatus.NEUTRAL, "Região norte-noroeste"),
        KnownNeighborhood("Alto São João", -16.7254, -43.8635, NeighborhoodStatus.NEUTRAL, "Região central"),
        KnownNeighborhood("Vila Atlântida", -16.7276, -43.8482, NeighborhoodStatus.NEUTRAL, "Região leste próxima ao centro"),
        KnownNeighborhood("Santo Inácio", -16.7538, -43.8712, NeighborhoodStatus.NEUTRAL, "Região sul"),
        KnownNeighborhood("Nossa Senhora das Graças", -16.7438, -43.8448, NeighborhoodStatus.NEUTRAL, "Região sudeste"),
        KnownNeighborhood("Jardim Alvorada", -16.7504, -43.8455, NeighborhoodStatus.NEUTRAL, "Região sudeste"),
        KnownNeighborhood("Roxo Verde", -16.7318, -43.8422, NeighborhoodStatus.NEUTRAL, "Região leste"),
        KnownNeighborhood("Vila Sion", -16.7412, -43.8708, NeighborhoodStatus.NEUTRAL, "Próximo ao Morada do Sol"),
        KnownNeighborhood("Alice Maia", -16.7274, -43.8405, NeighborhoodStatus.NEUTRAL, "Região leste"),
        KnownNeighborhood("Cidade Industrial", -16.6980, -43.8350, NeighborhoodStatus.AVOIDED, "Distrito industrial afastado e retorno longo"),
        KnownNeighborhood("Village do Lago", -16.6885, -43.8412, NeighborhoodStatus.AVOIDED, "Retorno longo e baixa iluminação em trechos"),
        KnownNeighborhood("Delfino Magalhães", -16.6962, -43.8585, NeighborhoodStatus.AVOIDED, "Zona de atenção redobrada no período noturno"),
        KnownNeighborhood("Conferência Cristo Rei", -16.6915, -43.8672, NeighborhoodStatus.AVOIDED, "Distante do polo central"),
        KnownNeighborhood("Clarice Athayde", -16.6995, -43.8460, NeighborhoodStatus.AVOIDED, "Bairro periférico, retorno sem demanda"),
        KnownNeighborhood("Vila Oliveira", -16.7062, -43.8415, NeighborhoodStatus.AVOIDED, "Atenção redobrada segundo relatos de entregadores"),
        KnownNeighborhood("Alterosa", -16.7032, -43.8825, NeighborhoodStatus.AVOIDED, "Acesso difícil e retorno longo"),
        KnownNeighborhood("Eldorado", -16.7082, -43.8895, NeighborhoodStatus.AVOIDED, "Extremo noroeste, baixa taxa de retorno"),
        KnownNeighborhood("Renascença", -16.6940, -43.8768, NeighborhoodStatus.AVOIDED, "Zona periférica norte"),
        KnownNeighborhood("Santos Reis", -16.7018, -43.8648, NeighborhoodStatus.AVOIDED, "Atenção em trechos secundários"),
        KnownNeighborhood("Independência", -16.7370, -43.8295, NeighborhoodStatus.AVOIDED, "Muito afastado do Centro (retorno longo)"),
        KnownNeighborhood("Planalto", -16.7104, -43.8330, NeighborhoodStatus.AVOIDED, "Região leste afastada"),
        KnownNeighborhood("Jardim Primavera", -16.7590, -43.8462, NeighborhoodStatus.AVOIDED, "Extremo sudeste com retorno longo")
    )

    private val neighborhoodAliases: Map<String, String> = mapOf(
        "jd sao luiz" to "Jardim São Luiz",
        "jd sao luis" to "Jardim São Luiz",
        "jardim sao luis" to "Jardim São Luiz",
        "jd panorama" to "Jardim Panorama",
        "jd primavera" to "Jardim Primavera",
        "jd brasil" to "Jardim Brasil",
        "jd alvorada" to "Jardim Alvorada",
        "maj prates" to "Major Prates",
        "vl brasilia" to "Vila Brasília",
        "vl oliveira" to "Vila Oliveira",
        "vl guilhermina" to "Vila Guilhermina",
        "vl sion" to "Vila Sion",
        "vl atlantida" to "Vila Atlântida",
        "vl exposicao" to "Vila Exposição",
        "vl mauriceia" to "Vila Mauricéia",
        "pq municipal" to "Morada do Parque",
        "sto antonio" to "Santo Antônio",
        "sta rita" to "Santa Rita",
        "sta lucia" to "Santa Lúcia",
        "ns das gracas" to "Nossa Senhora das Graças",
        "n s das gracas" to "Nossa Senhora das Graças",
        "cristo rei" to "Conferência Cristo Rei",
        "village lago" to "Village do Lago",
        "delfino" to "Delfino Magalhães",
        "sao judas" to "São Judas Tadeu"
    )

    private val landmarkHints: Map<String, String> = mapOf(
        "montes claros shopping" to "Augusta Mota",
        "moc shopping" to "Augusta Mota",
        "ibituruna center" to "Ibituruna",
        "shopping popular" to "Centro",
        "mercado municipal" to "Centro",
        "praca dr carlos" to "Centro",
        "praca doutor carlos" to "Centro",
        "praca da matriz" to "Centro",
        "santa casa" to "Centro",
        "aroldo tourinho" to "Todos os Santos",
        "dilson godinho" to "Cândida Câmara",
        "unimontes" to "Universitário",
        "campus darcy ribeiro" to "Universitário",
        "rodoviaria" to "Canelas",
        "terminal rodoviario" to "Canelas",
        "parque de exposicoes" to "Vila Exposição",
        "parque municipal" to "Morada do Parque",
        "milton prates" to "Morada do Parque",
        "ceanorte" to "Cidade Industrial",
        "deputado esteves rodrigues" to "Centro",
        "esteves rodrigues" to "Centro",
        "av sanitaria" to "Centro",
        "avenida sanitaria" to "Centro",
        "ovidio de abreu" to "Centro",
        "cel celestino" to "Centro",
        "coronel celestino" to "Centro",
        "mestra fininha" to "Jardim São Luiz",
        "dulce sarmento" to "Melo",
        "jose correa machado" to "Ibituruna",
        "correa machado" to "Ibituruna",
        "pedro alvares cabral" to "Ibituruna",
        "francisco gaetani" to "Major Prates",
        "sidney chaves" to "Edgar Pereira",
        "geraldo athayde" to "Alto São João",
        "cula mangabeira" to "Cândida Câmara",
        "donato quintino" to "Cidade Nova",
        "magalhaes pinto" to "Alcides Rabelo",
        "joao xxiii" to "Santos Reis",
        "plinio ribeiro" to "Jardim Brasil"
    )

    private val streetPrefixRegex = Regex(
        "^(?:r|rua|av|avenida|tv|travessa|praca|pc|al|alameda|rod|rodovia|estrada|via)\\b.*"
    )
    private val complementPrefixRegex = Regex(
        "^(?:ap|apt|apto|apartamento|bl|bloco|cs|casa|qd|quadra|lt|lote|lj|loja|sl|sala|fundos|km|n|no|num)\\b.*"
    )
    private val cepRegex = Regex("\\b\\d{5}-?\\d{3}\\b")
    private val cityNoiseRegex = Regex("(?i)\\b(montes claros|minas gerais|mg|brasil|brazil)\\b")

    fun defaultRuleEntities(): List<NeighborhoodRuleEntity> = knownNeighborhoods.map { item ->
        NeighborhoodRuleEntity(
            name = item.name,
            normalizedKey = normalize(item.name),
            status = item.defaultStatus.name,
            notes = item.defaultNote,
            isCustom = false
        )
    }

    fun normalize(text: String): String {
        val decomposed = Normalizer.normalize(text.lowercase().trim(), Normalizer.Form.NFD)
        return decomposed.replace(Regex("\\p{InCombiningDiacriticalMarks}+"), "")
            .replace(Regex("[^a-z0-9\\s]"), " ")
            .replace(Regex("\\s+"), " ")
            .trim()
    }

    fun normalizeAddressCacheKey(address: String): String {
        val cleaned = stripNoiseFromAddress(address)
        return normalize(cleaned.ifBlank { address })
    }

    fun identifyNeighborhood(
        address: String,
        point: GeoPoint?,
        rules: List<NeighborhoodRuleEntity>
    ): NeighborhoodMatchResult {
        val sortedRules = rules
            .filter { it.normalizedKey.isNotBlank() }
            .sortedByDescending { it.normalizedKey.length }

        if (address.isNotBlank() && sortedRules.isNotEmpty()) {
            val segments = extractCandidateNeighborhoodSegments(address)
            for (segment in segments) {
                val normSeg = normalize(segment)
                if (normSeg.isBlank()) continue
                findExactOrBoundaryRuleMatch(normSeg, sortedRules)?.let { rule ->
                    return NeighborhoodMatchResult(rule.name, NeighborhoodConfidence.HIGH, rule, "Segmento do endereço")
                }
                findAliasRuleMatch(normSeg, rules)?.let { rule ->
                    return NeighborhoodMatchResult(rule.name, NeighborhoodConfidence.HIGH, rule, "Sigla/variação de bairro")
                }
            }
        }

        val meta = point?.geocoderMetadata
        if (meta != null && isWithinMontesClarosBounds(point.latitude, point.longitude)) {
            val subLocality = meta.subLocality?.trim().orEmpty()
            if (subLocality.isNotBlank()) {
                val normSub = normalize(subLocality)
                if (normSub.isNotBlank() && !isCityOrNoiseOnly(normSub)) {
                    findExactOrBoundaryRuleMatch(normSub, sortedRules)?.let { rule ->
                        return NeighborhoodMatchResult(rule.name, NeighborhoodConfidence.HIGH, rule, "Geocoder (subLocality)")
                    }
                    findAliasRuleMatch(normSub, rules)?.let { rule ->
                        return NeighborhoodMatchResult(rule.name, NeighborhoodConfidence.HIGH, rule, "Geocoder (subLocality/alias)")
                    }
                    if (!streetPrefixRegex.matches(normSub) && !complementPrefixRegex.matches(normSub)) {
                        return NeighborhoodMatchResult(subLocality, NeighborhoodConfidence.MEDIUM, null, "Geocoder confirmado")
                    }
                }
            }
        }

        if (address.isNotBlank() && sortedRules.isNotEmpty()) {
            val cleanedFull = normalize(stripNoiseFromAddress(address))
            if (cleanedFull.isNotBlank()) {
                sortedRules.firstOrNull { rule ->
                    containsWordBoundaryOutsideStreetPrefix(cleanedFull, rule.normalizedKey)
                }?.let { rule ->
                    return NeighborhoodMatchResult(rule.name, NeighborhoodConfidence.HIGH, rule, "Endereço confirmado")
                }
                findAliasRuleMatch(cleanedFull, rules)?.let { rule ->
                    return NeighborhoodMatchResult(rule.name, NeighborhoodConfidence.HIGH, rule, "Variação no endereço")
                }
            }
        }

        val hintSearchTexts = listOfNotNull(
            address.takeIf { it.isNotBlank() },
            meta?.thoroughfare,
            meta?.featureName,
            meta?.addressLine
        )
        for (text in hintSearchTexts) {
            val normText = normalize(text)
            val landmarkMatch = landmarkHints.entries
                .sortedByDescending { it.key.length }
                .firstOrNull { (hint, _) -> containsWordBoundary(normText, normalize(hint)) }
            if (landmarkMatch != null) {
                val targetName = landmarkMatch.value
                val matchedRule = findRuleByCanonicalName(targetName, rules)
                return NeighborhoodMatchResult(
                    name = matchedRule?.name ?: targetName,
                    confidence = NeighborhoodConfidence.MEDIUM,
                    rule = matchedRule,
                    sourceDetail = "Avenida / ponto de referência"
                )
            }
        }

        if (address.isNotBlank() && sortedRules.isNotEmpty()) {
            val fallbackFull = normalize(stripNoiseFromAddress(address)).ifBlank { normalize(address) }
            sortedRules.firstOrNull { rule ->
                containsWordBoundary(fallbackFull, rule.normalizedKey)
            }?.let { rule ->
                return NeighborhoodMatchResult(rule.name, NeighborhoodConfidence.MEDIUM, rule, "Menção no endereço")
            }
        }

        if (point != null && isWithinMontesClarosBounds(point.latitude, point.longitude)) {
            val nearest = findNearestCatalogNeighborhood(point.latitude, point.longitude, maxDistanceKm = 2.5)
            if (nearest != null) {
                val (catalogItem, distanceKm) = nearest
                val matchedRule = findRuleByCanonicalName(catalogItem.name, rules)
                val confidence = if (distanceKm <= 1.2) NeighborhoodConfidence.MEDIUM else NeighborhoodConfidence.LOW
                return NeighborhoodMatchResult(
                    name = matchedRule?.name ?: catalogItem.name,
                    confidence = confidence,
                    rule = matchedRule,
                    sourceDetail = if (confidence == NeighborhoodConfidence.MEDIUM) "Coordenada próxima" else "Coordenada aproximada"
                )
            }
        }

        return NeighborhoodMatchResult(
            name = UNIDENTIFIED_NEIGHBORHOOD,
            confidence = NeighborhoodConfidence.UNIDENTIFIED,
            rule = null,
            sourceDetail = "Não localizado no catálogo ou Geocoder"
        )
    }

    fun detectNeighborhoodRule(
        address: String,
        rules: List<NeighborhoodRuleEntity>
    ): NeighborhoodRuleEntity? = identifyNeighborhood(address, null, rules).rule

    fun detectNeighborhoodByCoordinates(
        latitude: Double,
        longitude: Double,
        maxDistanceKm: Double = 2.5
    ): KnownNeighborhood? = findNearestCatalogNeighborhood(latitude, longitude, maxDistanceKm)?.first

    fun detectNeighborhoodRuleByAddressOrCoordinates(
        address: String,
        point: GeoPoint?,
        rules: List<NeighborhoodRuleEntity>
    ): NeighborhoodRuleEntity? = identifyNeighborhood(address, point, rules).rule

    fun extractNeighborhoodLabel(
        address: String,
        rules: List<NeighborhoodRuleEntity>,
        point: GeoPoint? = null
    ): String = identifyNeighborhood(address, point, rules).name

    fun resolveCoordinatesFromCatalog(address: String): GeoPoint? {
        if (address.isBlank()) return null

        val sortedCatalog = knownNeighborhoods.sortedByDescending { normalize(it.name).length }

        val segments = extractCandidateNeighborhoodSegments(address)
        for (segment in segments) {
            val normSeg = normalize(segment)
            if (normSeg.isBlank()) continue

            sortedCatalog.firstOrNull { item ->
                containsWordBoundary(normSeg, normalize(item.name))
            }?.let { return GeoPoint(it.latitude, it.longitude, it.name) }

            findAliasCatalogMatch(normSeg)?.let {
                return GeoPoint(it.latitude, it.longitude, it.name)
            }
        }

        val cleanedFull = normalize(stripNoiseFromAddress(address))
        if (cleanedFull.isNotBlank()) {
            sortedCatalog.firstOrNull { item ->
                containsWordBoundaryOutsideStreetPrefix(cleanedFull, normalize(item.name))
            }?.let { return GeoPoint(it.latitude, it.longitude, it.name) }

            findAliasCatalogMatch(cleanedFull)?.let {
                return GeoPoint(it.latitude, it.longitude, it.name)
            }
        }

        val fullNorm = normalize(address)
        val landmark = landmarkHints.entries
            .sortedByDescending { it.key.length }
            .firstOrNull { (hint, _) -> containsWordBoundary(fullNorm, normalize(hint)) }
            ?.value
        if (landmark != null) {
            knownNeighborhoods.firstOrNull { it.name == landmark }?.let {
                return GeoPoint(it.latitude, it.longitude, it.name)
            }
        }

        sortedCatalog.firstOrNull { item ->
            containsWordBoundary(cleanedFull.ifBlank { fullNorm }, normalize(item.name))
        }?.let { return GeoPoint(it.latitude, it.longitude, it.name) }

        return null
    }

    private fun findNearestCatalogNeighborhood(
        latitude: Double,
        longitude: Double,
        maxDistanceKm: Double
    ): Pair<KnownNeighborhood, Double>? {
        if (!isWithinMontesClarosBounds(latitude, longitude)) return null
        var bestMatch: KnownNeighborhood? = null
        var bestDistanceKm = Double.MAX_VALUE
        for (item in knownNeighborhoods) {
            val dKm = approxHaversineKm(latitude, longitude, item.latitude, item.longitude)
            if (dKm < bestDistanceKm) {
                bestDistanceKm = dKm
                bestMatch = item
            }
        }
        return if (bestMatch != null && bestDistanceKm <= maxDistanceKm) {
            bestMatch to bestDistanceKm
        } else {
            null
        }
    }

    private fun findRuleByCanonicalName(
        canonicalName: String,
        rules: List<NeighborhoodRuleEntity>
    ): NeighborhoodRuleEntity? {
        val targetNorm = normalize(canonicalName)
        return rules.firstOrNull { it.normalizedKey == targetNorm || normalize(it.name) == targetNorm }
    }

    private fun isCityOrNoiseOnly(normalizedText: String): Boolean =
        normalizedText in setOf("montes claros", "minas gerais", "mg", "brasil", "brazil")

    fun approxHaversineKm(lat1: Double, lon1: Double, lat2: Double, lon2: Double): Double {
        val earthRadiusKm = 6371.0
        val dLat = Math.toRadians(lat2 - lat1)
        val dLon = Math.toRadians(lon2 - lon1)
        val rLat1 = Math.toRadians(lat1)
        val rLat2 = Math.toRadians(lat2)
        val sinLat = Math.sin(dLat / 2.0)
        val sinLon = Math.sin(dLon / 2.0)
        val a = sinLat * sinLat + Math.cos(rLat1) * Math.cos(rLat2) * sinLon * sinLon
        return 2.0 * earthRadiusKm * Math.atan2(Math.sqrt(a), Math.sqrt(1.0 - a))
    }

    private fun extractCandidateNeighborhoodSegments(address: String): List<String> {
        val result = mutableListOf<String>()
        val cleaned = stripNoiseFromAddress(address)

        val bairroRegex = Regex("(?i)(?:\\bbairro\\b|\\bbr\\.?)\\s+([\\p{L}0-9\\s]{3,36})")
        bairroRegex.find(cleaned)?.groupValues?.getOrNull(1)?.let { match ->
            val trimmed = match.split(",", "-", "/").firstOrNull()?.trim().orEmpty()
            if (trimmed.isNotBlank()) result.add(trimmed)
        }

        val parts = cleaned.split("-", ",", "/", "•")
            .map { it.trim() }
            .filter { it.isNotBlank() }

        if (parts.size >= 2) {
            for (part in parts.asReversed()) {
                val normPart = normalize(part)
                if (normPart.isBlank() || normPart.all { it.isDigit() }) continue
                if (streetPrefixRegex.matches(normPart)) continue
                if (complementPrefixRegex.matches(normPart)) continue
                result.add(part)
            }
        }
        return result.distinct()
    }

    private fun stripNoiseFromAddress(address: String): String {
        return address
            .replace(cepRegex, " ")
            .replace(cityNoiseRegex, " ")
            .replace(Regex("\\s{2,}"), " ")
            .trim(' ', ',', '-', '/')
    }

    private fun findExactOrBoundaryRuleMatch(
        normalizedSegment: String,
        sortedRules: List<NeighborhoodRuleEntity>
    ): NeighborhoodRuleEntity? {
        sortedRules.firstOrNull { it.normalizedKey == normalizedSegment }?.let { return it }
        return sortedRules.firstOrNull { containsWordBoundary(normalizedSegment, it.normalizedKey) }
    }

    private fun findAliasRuleMatch(
        normalizedText: String,
        rules: List<NeighborhoodRuleEntity>
    ): NeighborhoodRuleEntity? {
        val canonical = neighborhoodAliases.entries
            .sortedByDescending { it.key.length }
            .firstOrNull { (alias, _) -> containsWordBoundary(normalizedText, alias) }
            ?.value ?: return null
        return findRuleByCanonicalName(canonical, rules)
    }

    private fun findAliasCatalogMatch(normalizedText: String): KnownNeighborhood? {
        val canonical = neighborhoodAliases.entries
            .sortedByDescending { it.key.length }
            .firstOrNull { (alias, _) -> containsWordBoundary(normalizedText, alias) }
            ?.value ?: return null
        return knownNeighborhoods.firstOrNull { it.name == canonical }
    }

    private fun containsWordBoundary(haystack: String, needle: String): Boolean {
        if (haystack.isBlank() || needle.isBlank()) return false
        val regex = Regex("(?:^|\\s)${Regex.escape(needle)}(?:\\s|$)")
        return regex.containsMatchIn(haystack)
    }

    private fun containsWordBoundaryOutsideStreetPrefix(haystack: String, needle: String): Boolean {
        if (haystack.isBlank() || needle.isBlank()) return false
        val regex = Regex("(?:^|\\s)${Regex.escape(needle)}(?:\\s|$)")
        val matches = regex.findAll(haystack)
        for (match in matches) {
            val prefixWindow = haystack.substring(0, match.range.first).trim()
            val lastWordBefore = prefixWindow.substringAfterLast(' ', "")
            val isStreetWord = lastWordBefore in setOf(
                "r", "rua", "av", "avenida", "tv", "travessa", "praca", "pc", "al", "alameda", "rodovia", "estrada"
            )
            if (!isStreetWord) return true
        }
        return false
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/domain/OfferParser.kt
package com.example.domain

data class ParsedOfferDraft(
    val offerPriceBrl: Double,
    val pickupAddress: String,
    val customerAddress: String,
    val rawSnippet: String,
    val isHighConfidence: Boolean
)

object OfferParser {

    private val priceRegex = Regex(
        """(?:R\$\s*|Valor[:\s]*R?\$?\s*)(\d{1,3}(?:\.\d{3})*[.,]\d{2}|\d+[.,]\d{2})""",
        RegexOption.IGNORE_CASE
    )
    private val standaloneCurrencyRegex = Regex("""R\$\s*(\d+[.,]\d{2})""", RegexOption.IGNORE_CASE)

    private val pickupMarkers = listOf(
        "retirada", "coleta", "loja", "restaurante", "estabelecimento",
        "origem", "buscar em", "pegar em", "retirar em", "de:"
    )

    private val customerMarkers = listOf(
        "entrega", "cliente", "destino", "entregar em", "levar para",
        "destinatário", "destinatario", "para:"
    )

    private val pickupMarkerRegexes = pickupMarkers.map { marker ->
        Regex("""(?i)(?:^|\b)${Regex.escape(marker.trimEnd(':'))}(?:\b|:)""")
    }

    private val customerMarkerRegexes = customerMarkers.map { marker ->
        Regex("""(?i)(?:^|\b)${Regex.escape(marker.trimEnd(':'))}(?:\b|:)""")
    }

    private val streetPattern = Regex(
        """(?i)\b(rua|r\.|av\.?|avenida|travessa|tv\.?|praça|praca|alameda|rodovia|estrada|b\.|bairro)\b.+"""
    )

    fun parse(rawText: String, requireDeliveryKeywords: Boolean = true): ParsedOfferDraft? {
        val cleanLines = rawText
            .lines()
            .map { it.trim() }
            .filter { it.isNotBlank() && it.length >= 2 }

        if (cleanLines.isEmpty()) return null
        val joined = cleanLines.joinToString("\n")

        val price = extractPrice(joined) ?: return null
        if (price <= 0.5 || price > 1500.0) return null

        val lowerJoined = joined.lowercase()
        val hasDeliveryContext = pickupMarkerRegexes.any { it.containsMatchIn(lowerJoined) } ||
            customerMarkerRegexes.any { it.containsMatchIn(lowerJoined) } ||
            lowerJoined.contains("mob lets") ||
            lowerJoined.contains("moblets") ||
            lowerJoined.contains("aceitar") ||
            lowerJoined.contains("nova oferta") ||
            lowerJoined.contains("corrida")

        if (requireDeliveryKeywords && !hasDeliveryContext) {
            return null
        }

        var pickupAddress: String? = null
        var customerAddress: String? = null

        for (i in cleanLines.indices) {
            val line = cleanLines[i]

            if (pickupAddress == null && pickupMarkerRegexes.any { it.containsMatchIn(line) }) {
                pickupAddress = extractValueAfterMarker(line, pickupMarkerRegexes)
                    ?: cleanLines.getOrNull(i + 1)?.takeIf { !isMarkerLine(it) && !looksLikePrice(it) }
            }

            if (customerAddress == null && customerMarkerRegexes.any { it.containsMatchIn(line) }) {
                customerAddress = extractValueAfterMarker(line, customerMarkerRegexes)
                    ?: cleanLines.getOrNull(i + 1)?.takeIf { !isMarkerLine(it) && !looksLikePrice(it) }
            }
        }

        if (pickupAddress == null || customerAddress == null) {
            val streetCandidates = cleanLines.filter { line ->
                !isMarkerLine(line) &&
                    streetPattern.containsMatchIn(line) &&
                    !looksLikePrice(line) &&
                    line != pickupAddress &&
                    line != customerAddress
            }
            if (pickupAddress == null && streetCandidates.isNotEmpty()) {
                pickupAddress = streetCandidates.first()
            }
            if (customerAddress == null) {
                customerAddress = streetCandidates.firstOrNull { it != pickupAddress }
            }
        }

        if (pickupAddress.isNullOrBlank() && customerAddress.isNullOrBlank()) {
            return null
        }

        val finalPickup = pickupAddress?.take(140).orEmpty()
        val finalCustomer = customerAddress?.take(140).orEmpty()

        return ParsedOfferDraft(
            offerPriceBrl = price,
            pickupAddress = finalPickup,
            customerAddress = finalCustomer,
            rawSnippet = joined.take(400),
            isHighConfidence = pickupAddress != null && customerAddress != null
        )
    }

    fun extractPrice(text: String): Double? {
        val match = priceRegex.find(text) ?: standaloneCurrencyRegex.find(text) ?: return null
        val rawNumber = match.groupValues.getOrNull(1) ?: return null
        val normalized = if (rawNumber.contains(",") && rawNumber.contains(".")) {
            rawNumber.replace(".", "").replace(",", ".")
        } else {
            rawNumber.replace(",", ".")
        }
        return normalized.toDoubleOrNull()
    }

    private fun extractValueAfterMarker(line: String, markerRegexes: List<Regex>): String? {
        val colonIndex = line.indexOf(':')
        if (colonIndex in 2 until line.length - 3) {
            val afterColon = line.substring(colonIndex + 1).trim()
            if (afterColon.length >= 4 && !looksLikePrice(afterColon)) {
                return afterColon
            }
        }
        for (regex in markerRegexes) {
            val match = regex.find(line)
            if (match != null) {
                val remainder = line.substring(match.range.last + 1)
                    .trimStart(' ', ':', '-', '•', '>')
                    .trim()
                if (remainder.length >= 4 && !looksLikePrice(remainder)) {
                    return remainder
                }
            }
        }
        return null
    }

    private fun isMarkerLine(line: String): Boolean {
        return pickupMarkerRegexes.any { it.containsMatchIn(line) } ||
            customerMarkerRegexes.any { it.containsMatchIn(line) }
    }

    private fun looksLikePrice(line: String): Boolean =
        standaloneCurrencyRegex.containsMatchIn(line)
}
EOF

cat << 'EOF' > app/src/main/java/com/example/domain/OcrFallbackProcessor.kt
package com.example.domain

import android.content.Context
import android.graphics.Bitmap
import android.net.Uri
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.text.TextRecognition
import com.google.mlkit.vision.text.latin.TextRecognizerOptions
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.withTimeout
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException

class OcrFallbackProcessor {

    private val recognizer by lazy {
        TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS)
    }

    suspend fun extractTextFromBitmap(bitmap: Bitmap): String {
        val inputImage = InputImage.fromBitmap(bitmap, 0)
        return processImage(inputImage)
    }

    suspend fun extractTextFromUri(context: Context, uri: Uri): String {
        val inputImage = InputImage.fromFilePath(context, uri)
        return processImage(inputImage)
    }

    private suspend fun processImage(image: InputImage): String {
        return try {
            withTimeout(OCR_PROCESS_TIMEOUT_MS) {
                suspendCancellableCoroutine { continuation ->
                    recognizer.process(image)
                        .addOnSuccessListener { visionText ->
                            if (continuation.isActive) {
                                continuation.resume(visionText.text)
                            }
                        }
                        .addOnFailureListener { exception ->
                            if (continuation.isActive) {
                                continuation.resumeWithException(exception)
                            }
                        }
                }
            }
        } catch (e: CancellationException) {
            throw e
        }
    }

    companion object {
        private const val OCR_PROCESS_TIMEOUT_MS = 6000L
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/domain/LocationHelper.kt
package com.example.domain

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import androidx.core.content.ContextCompat
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.Priority
import com.google.android.gms.tasks.CancellationTokenSource
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.withTimeoutOrNull
import kotlin.coroutines.resume

data class DriverLocationResult(
    val point: GeoPoint,
    val usedGps: Boolean
)

class LocationHelper(private val context: Context) {

    private val fusedClient by lazy {
        LocationServices.getFusedLocationProviderClient(context)
    }

    @Volatile
    private var lastFixPoint: GeoPoint? = null

    @Volatile
    private var lastFixTimestampMs: Long = 0L

    fun hasLocationPermission(): Boolean {
        val fine = ContextCompat.checkSelfPermission(
            context,
            Manifest.permission.ACCESS_FINE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED
        val coarse = ContextCompat.checkSelfPermission(
            context,
            Manifest.permission.ACCESS_COARSE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED
        return fine || coarse
    }

    @SuppressLint("MissingPermission")
    suspend fun getCurrentLocationOrFallback(): DriverLocationResult {
        if (!hasLocationPermission()) {
            return DriverLocationResult(
                point = MontesClarosGeoCatalog.DOWNTOWN_MONTES_CLAROS,
                usedGps = false
            )
        }

        val now = System.currentTimeMillis()
        val recent = lastFixPoint
        if (recent != null && (now - lastFixTimestampMs) < GPS_CACHE_TTL_MS) {
            return DriverLocationResult(point = recent, usedGps = true)
        }

        val current = try {
            withTimeoutOrNull(GPS_TIMEOUT_MS) {
                suspendCancellableCoroutine<GeoPoint?> { cont ->
                    val tokenSource = CancellationTokenSource()
                    fusedClient.getCurrentLocation(Priority.PRIORITY_BALANCED_POWER_ACCURACY, tokenSource.token)
                        .addOnSuccessListener { location ->
                            if (cont.isActive) {
                                if (location != null) {
                                    cont.resume(GeoPoint(location.latitude, location.longitude, "Localização GPS Atual"))
                                } else {
                                    fusedClient.lastLocation
                                        .addOnSuccessListener { last ->
                                            if (cont.isActive) {
                                                cont.resume(
                                                    last?.let {
                                                        GeoPoint(it.latitude, it.longitude, "Última Localização GPS")
                                                    }
                                                )
                                            }
                                        }
                                        .addOnFailureListener {
                                            if (cont.isActive) cont.resume(null)
                                        }
                                }
                            }
                        }
                        .addOnFailureListener {
                            if (cont.isActive) cont.resume(null)
                        }
                    cont.invokeOnCancellation { tokenSource.cancel() }
                }
            }
        } catch (e: CancellationException) {
            throw e
        } catch (_: SecurityException) {
            null
        } catch (_: Exception) {
            null
        }

        return if (current != null) {
            lastFixPoint = current
            lastFixTimestampMs = System.currentTimeMillis()
            DriverLocationResult(point = current, usedGps = true)
        } else {
            DriverLocationResult(
                point = MontesClarosGeoCatalog.DOWNTOWN_MONTES_CLAROS,
                usedGps = false
            )
        }
    }

    companion object {
        private const val GPS_TIMEOUT_MS = 2200L
        private const val GPS_CACHE_TTL_MS = 15_000L
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/domain/RouteCalculator.kt
package com.example.domain

import android.content.Context
import android.location.Address
import android.location.Geocoder
import android.os.Build
import com.example.data.GeoCacheStore
import com.example.data.InMemoryGeoCacheStore
import com.example.data.local.CachedAddressEntity
import com.example.data.local.CachedRouteEntity
import com.squareup.moshi.JsonClass
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.async
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.withContext
import kotlinx.coroutines.withTimeoutOrNull
import okhttp3.ConnectionPool
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query
import java.util.Locale
import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.TimeUnit
import kotlin.coroutines.resume
import kotlin.math.atan2
import kotlin.math.cos
import kotlin.math.pow
import kotlin.math.sin
import kotlin.math.sqrt

@JsonClass(generateAdapter = true)
data class OsrmRouteResponse(
    val code: String,
    val routes: List<OsrmRoute> = emptyList()
)

@JsonClass(generateAdapter = true)
data class OsrmRoute(
    val distance: Double = 0.0,
    val duration: Double = 0.0,
    val legs: List<OsrmLeg> = emptyList()
)

@JsonClass(generateAdapter = true)
data class OsrmLeg(
    val distance: Double = 0.0,
    val duration: Double = 0.0
)

interface OsrmRoutingApi {
    @GET("route/v1/driving/{coordinates}")
    suspend fun getDrivingRoute(
        @Path("coordinates", encoded = true) coordinates: String,
        @Query("overview") overview: String = "false",
        @Query("steps") steps: String = "false",
        @Query("alternatives") alternatives: String = "false",
        @Query("annotations") annotations: String = "false"
    ): OsrmRouteResponse
}

data class RouteCalculationResult(
    val leg1CurrentToPickupKm: Double,
    val leg2PickupToCustomerKm: Double,
    val leg3CustomerToCenterKm: Double,
    val totalKm: Double,
    val routeSource: String,
    val fromCache: Boolean = false,
    val pickupPoint: GeoPoint? = null,
    val customerPoint: GeoPoint? = null
)

sealed class RouteResolutionResult {
    data class Resolved(val route: RouteCalculationResult) : RouteResolutionResult()
    data class UnresolvedAddress(
        val missingPickup: Boolean,
        val missingCustomer: Boolean,
        val pickupAddress: String,
        val customerAddress: String,
        val reason: String
    ) : RouteResolutionResult()
}

class RouteCalculator(
    private val context: Context,
    private val cacheStore: GeoCacheStore = InMemoryGeoCacheStore(),
    private val osrmApi: OsrmRoutingApi = createDefaultOsrmApi(),
    private val geocoderOverride: (suspend (String) -> GeoPoint?)? = null
) {

    private val sharedFetchScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private val inFlightAddresses = ConcurrentHashMap<String, CompletableDeferred<GeoPoint?>>()
    private val inFlightRoutes = ConcurrentHashMap<String, CompletableDeferred<RouteCalculationResult>>()

    suspend fun calculateCompleteRoute(
        currentLocation: GeoPoint,
        pickupAddress: String,
        customerAddress: String,
        useOsrmRoadRouting: Boolean
    ): RouteResolutionResult = withContext(Dispatchers.IO) {
        val (pickupPoint, customerPoint) = coroutineScope {
            val pickupDeferred = async { resolveAddressPoint(pickupAddress) }
            val customerDeferred = async { resolveAddressPoint(customerAddress) }
            pickupDeferred.await() to customerDeferred.await()
        }

        val centerPoint = MontesClarosGeoCatalog.DOWNTOWN_MONTES_CLAROS
        val validationError = validateFourRoutePoints(
            currentLocation = currentLocation,
            pickupPoint = pickupPoint,
            customerPoint = customerPoint,
            centerPoint = centerPoint,
            pickupAddress = pickupAddress,
            customerAddress = customerAddress
        )
        if (validationError != null) {
            return@withContext validationError
        }

        val validPickup = pickupPoint!!
        val validCustomer = customerPoint!!

        val routeKey = buildRouteKey(
            currentLocation = currentLocation,
            pickupPoint = validPickup,
            customerPoint = validCustomer,
            centerPoint = centerPoint,
            useOsrm = useOsrmRoadRouting
        )

        val now = System.currentTimeMillis()
        cacheStore.getValidRoute(routeKey, now)?.let { cached ->
            return@withContext RouteResolutionResult.Resolved(
                RouteCalculationResult(
                    leg1CurrentToPickupKm = cached.leg1Km,
                    leg2PickupToCustomerKm = cached.leg2Km,
                    leg3CustomerToCenterKm = cached.leg3Km,
                    totalKm = cached.totalKm,
                    routeSource = cached.routeSource,
                    fromCache = true,
                    pickupPoint = validPickup,
                    customerPoint = validCustomer
                )
            )
        }

        val route = computeOrAwaitRoute(
            routeKey = routeKey,
            currentLocation = currentLocation,
            pickupPoint = validPickup,
            customerPoint = validCustomer,
            centerPoint = centerPoint,
            useOsrmRoadRouting = useOsrmRoadRouting
        ).copy(
            pickupPoint = validPickup,
            customerPoint = validCustomer
        )

        RouteResolutionResult.Resolved(route)
    }

    private fun validateFourRoutePoints(
        currentLocation: GeoPoint,
        pickupPoint: GeoPoint?,
        customerPoint: GeoPoint?,
        centerPoint: GeoPoint,
        pickupAddress: String,
        customerAddress: String
    ): RouteResolutionResult.UnresolvedAddress? {
        val missingPickup = pickupPoint == null || !isValidCoordinate(pickupPoint) ||
            !MontesClarosGeoCatalog.isWithinMontesClarosBounds(pickupPoint.latitude, pickupPoint.longitude)
        val missingCustomer = customerPoint == null || !isValidCoordinate(customerPoint) ||
            !MontesClarosGeoCatalog.isWithinMontesClarosBounds(customerPoint.latitude, customerPoint.longitude)

        if (missingPickup || missingCustomer) {
            val missingDesc = when {
                missingPickup && missingCustomer ->
                    "retirada (${pickupAddress.ifBlank { "não informado" }}) e cliente (${customerAddress.ifBlank { "não informado" }})"
                missingPickup ->
                    "retirada (${pickupAddress.ifBlank { "não informado" }})"
                else ->
                    "cliente (${customerAddress.ifBlank { "não informado" }})"
            }
            return RouteResolutionResult.UnresolvedAddress(
                missingPickup = missingPickup,
                missingCustomer = missingCustomer,
                pickupAddress = pickupAddress,
                customerAddress = customerAddress,
                reason = "Endereço não localizado em Montes Claros: $missingDesc. Cálculo bloqueado para evitar km fictício."
            )
        }

        if (!isValidCoordinate(currentLocation) || !isValidCoordinate(centerPoint) ||
            !MontesClarosGeoCatalog.isWithinMontesClarosBounds(centerPoint.latitude, centerPoint.longitude)
        ) {
            return RouteResolutionResult.UnresolvedAddress(
                missingPickup = false,
                missingCustomer = false,
                pickupAddress = pickupAddress,
                customerAddress = customerAddress,
                reason = "Ponto de partida (GPS) ou referência do Centro inválido. Cálculo bloqueado."
            )
        }

        val distanceFromCenterKm = haversineKm(currentLocation, centerPoint)
        if (!distanceFromCenterKm.isFinite() || distanceFromCenterKm > MAX_START_RADIUS_FROM_MOC_KM) {
            return RouteResolutionResult.UnresolvedAddress(
                missingPickup = false,
                missingCustomer = false,
                pickupAddress = pickupAddress,
                customerAddress = customerAddress,
                reason = "Localização GPS atual fora da área operacional de Montes Claros. Verifique o GPS."
            )
        }

        return null
    }

    private fun isValidCoordinate(point: GeoPoint): Boolean {
        if (!point.latitude.isFinite() || !point.longitude.isFinite()) return false
        if (point.latitude == 0.0 && point.longitude == 0.0) return false
        return point.latitude in -90.0..90.0 && point.longitude in -180.0..180.0
    }

    private suspend fun computeOrAwaitRoute(
        routeKey: String,
        currentLocation: GeoPoint,
        pickupPoint: GeoPoint,
        customerPoint: GeoPoint,
        centerPoint: GeoPoint,
        useOsrmRoadRouting: Boolean
    ): RouteCalculationResult {
        inFlightRoutes[routeKey]?.let { existing ->
            return existing.await()
        }

        val created = CompletableDeferred<RouteCalculationResult>()
        val raceWinner = inFlightRoutes.putIfAbsent(routeKey, created)
        if (raceWinner != null) {
            return raceWinner.await()
        }

        sharedFetchScope.launch {
            try {
                val computed = executeRouteCalculation(
                    routeKey = routeKey,
                    currentLocation = currentLocation,
                    pickupPoint = pickupPoint,
                    customerPoint = customerPoint,
                    centerPoint = centerPoint,
                    useOsrmRoadRouting = useOsrmRoadRouting
                )
                created.complete(computed)
            } catch (e: Throwable) {
                created.completeExceptionally(e)
            } finally {
                inFlightRoutes.remove(routeKey, created)
            }
        }

        return created.await()
    }

    private suspend fun executeRouteCalculation(
        routeKey: String,
        currentLocation: GeoPoint,
        pickupPoint: GeoPoint,
        customerPoint: GeoPoint,
        centerPoint: GeoPoint,
        useOsrmRoadRouting: Boolean
    ): RouteCalculationResult {
        if (useOsrmRoadRouting) {
            val osrmResult = fetchOsrmRoute(currentLocation, pickupPoint, customerPoint, centerPoint)
            if (osrmResult != null) {
                val now = System.currentTimeMillis()
                cacheStore.putRoute(
                    CachedRouteEntity(
                        routeKey = routeKey,
                        leg1Km = osrmResult.leg1CurrentToPickupKm,
                        leg2Km = osrmResult.leg2PickupToCustomerKm,
                        leg3Km = osrmResult.leg3CustomerToCenterKm,
                        totalKm = osrmResult.totalKm,
                        routeSource = osrmResult.routeSource,
                        createdAt = now,
                        expiresAt = now + OSRM_ROUTE_TTL_MS
                    )
                )
                return osrmResult
            }

            val staleRealRoad = cacheStore.getStaleRoute(routeKey)
                ?.takeIf { it.routeSource == ROUTE_SOURCE_OSRM }
            if (staleRealRoad != null) {
                return RouteCalculationResult(
                    leg1CurrentToPickupKm = staleRealRoad.leg1Km,
                    leg2PickupToCustomerKm = staleRealRoad.leg2Km,
                    leg3CustomerToCenterKm = staleRealRoad.leg3Km,
                    totalKm = staleRealRoad.totalKm,
                    routeSource = staleRealRoad.routeSource,
                    fromCache = true
                )
            }
        }

        val urbanFactor = 1.32
        val l1 = round2((haversineKm(currentLocation, pickupPoint) * urbanFactor).coerceAtLeast(0.20))
        val l2 = round2((haversineKm(pickupPoint, customerPoint) * urbanFactor).coerceAtLeast(0.30))
        val l3 = round2((haversineKm(customerPoint, centerPoint) * urbanFactor).coerceAtLeast(0.20))
        val total = round2(l1 + l2 + l3)

        val fallbackResult = RouteCalculationResult(
            leg1CurrentToPickupKm = l1,
            leg2PickupToCustomerKm = l2,
            leg3CustomerToCenterKm = l3,
            totalKm = total,
            routeSource = ROUTE_SOURCE_URBAN_FALLBACK,
            fromCache = false
        )

        val now = System.currentTimeMillis()
        cacheStore.putRoute(
            CachedRouteEntity(
                routeKey = routeKey,
                leg1Km = l1,
                leg2Km = l2,
                leg3Km = l3,
                totalKm = total,
                routeSource = ROUTE_SOURCE_URBAN_FALLBACK,
                createdAt = now,
                expiresAt = now + FALLBACK_ROUTE_TTL_MS
            )
        )
        return fallbackResult
    }

    private suspend fun fetchOsrmRoute(
        currentLocation: GeoPoint,
        pickupPoint: GeoPoint,
        customerPoint: GeoPoint,
        centerPoint: GeoPoint
    ): RouteCalculationResult? {
        val coordPath = listOf(currentLocation, pickupPoint, customerPoint, centerPoint)
            .joinToString(";") { "${it.longitude},${it.latitude}" }

        return try {
            val response = withTimeoutOrNull(OSRM_REQUEST_TIMEOUT_MS) {
                osrmApi.getDrivingRoute(
                    coordinates = coordPath,
                    overview = "false",
                    steps = "false",
                    alternatives = "false",
                    annotations = "false"
                )
            } ?: return null

            val legs = response.routes.firstOrNull()?.legs
            if (response.code.equals("Ok", ignoreCase = true) && legs != null && legs.size >= 3) {
                val raw1 = legs[0].distance
                val raw2 = legs[1].distance
                val raw3 = legs[2].distance
                if (!raw1.isFinite() || !raw2.isFinite() || !raw3.isFinite()) return null
                if (raw1 < 0.0 || raw2 < 0.0 || raw3 < 0.0) return null

                val l1 = round2((raw1 / 1000.0).coerceAtLeast(0.15))
                val l2 = round2((raw2 / 1000.0).coerceAtLeast(0.15))
                val l3 = round2((raw3 / 1000.0).coerceAtLeast(0.15))
                val total = round2(l1 + l2 + l3)
                if (total > MAX_VALID_URBAN_ROUTE_KM) return null

                RouteCalculationResult(
                    leg1CurrentToPickupKm = l1,
                    leg2PickupToCustomerKm = l2,
                    leg3CustomerToCenterKm = l3,
                    totalKm = total,
                    routeSource = ROUTE_SOURCE_OSRM,
                    fromCache = false
                )
            } else {
                null
            }
        } catch (e: CancellationException) {
            throw e
        } catch (_: Exception) {
            null
        }
    }

    suspend fun resolveAddressPoint(rawAddress: String): GeoPoint? {
        val trimmed = rawAddress.trim()
        if (trimmed.isBlank()) return null

        val cacheKey = MontesClarosGeoCatalog.normalizeAddressCacheKey(trimmed)
        if (cacheKey.isBlank()) return null

        val now = System.currentTimeMillis()
        cacheStore.getValidAddress(cacheKey, now)?.let { cached ->
            val cachedNeighborhood = cached.resolvedNeighborhood
                .takeIf { it.isNotBlank() && !MontesClarosGeoCatalog.isUnidentified(it) }
            return GeoPoint(
                latitude = cached.latitude,
                longitude = cached.longitude,
                label = cachedNeighborhood ?: trimmed,
                geocoderMetadata = if (cached.resolutionSource == ADDRESS_SOURCE_GEOCODER && cachedNeighborhood != null) {
                    GeocoderPlaceMetadata(subLocality = cachedNeighborhood)
                } else {
                    null
                }
            )
        }

        inFlightAddresses[cacheKey]?.let { existing ->
            return existing.await()
        }

        val created = CompletableDeferred<GeoPoint?>()
        val raceWinner = inFlightAddresses.putIfAbsent(cacheKey, created)
        if (raceWinner != null) {
            return raceWinner.await()
        }

        sharedFetchScope.launch {
            try {
                val resolved = executeAddressResolution(trimmed, cacheKey)
                created.complete(resolved)
            } catch (e: Throwable) {
                created.completeExceptionally(e)
            } finally {
                inFlightAddresses.remove(cacheKey, created)
            }
        }

        return created.await()
    }

    private suspend fun executeAddressResolution(
        rawAddress: String,
        cacheKey: String
    ): GeoPoint? {
        val catalogPoint = MontesClarosGeoCatalog.resolveCoordinatesFromCatalog(rawAddress)
        val hasStreetDetail = hasStreetOrNumberDetail(rawAddress)

        val geocoded = if (hasStreetDetail || catalogPoint == null) {
            geocodeInMontesClaros(rawAddress)
        } else {
            null
        }

        val now = System.currentTimeMillis()
        if (geocoded != null && MontesClarosGeoCatalog.isWithinMontesClarosBounds(geocoded.latitude, geocoded.longitude)) {
            val neighborhoodMatch = MontesClarosGeoCatalog.identifyNeighborhood(
                address = rawAddress,
                point = geocoded,
                rules = emptyList()
            )
            val resolvedLabel = when {
                !MontesClarosGeoCatalog.isUnidentified(neighborhoodMatch.name) -> neighborhoodMatch.name
                catalogPoint != null -> catalogPoint.label
                else -> MontesClarosGeoCatalog.UNIDENTIFIED_NEIGHBORHOOD
            }

            cacheStore.putAddress(
                CachedAddressEntity(
                    normalizedQuery = cacheKey,
                    originalQuery = rawAddress,
                    latitude = geocoded.latitude,
                    longitude = geocoded.longitude,
                    resolvedNeighborhood = resolvedLabel,
                    resolutionSource = ADDRESS_SOURCE_GEOCODER,
                    createdAt = now,
                    expiresAt = now + GEOCODER_ADDRESS_TTL_MS
                )
            )
            return geocoded
        }

        if (catalogPoint != null) {
            cacheStore.putAddress(
                CachedAddressEntity(
                    normalizedQuery = cacheKey,
                    originalQuery = rawAddress,
                    latitude = catalogPoint.latitude,
                    longitude = catalogPoint.longitude,
                    resolvedNeighborhood = catalogPoint.label,
                    resolutionSource = ADDRESS_SOURCE_CATALOG,
                    createdAt = now,
                    expiresAt = now + CATALOG_ADDRESS_TTL_MS
                )
            )
            return catalogPoint
        }

        val stale = cacheStore.getStaleAddress(cacheKey)
        if (stale != null && MontesClarosGeoCatalog.isWithinMontesClarosBounds(stale.latitude, stale.longitude)) {
            val staleNeighborhood = stale.resolvedNeighborhood
                .takeIf { it.isNotBlank() && !MontesClarosGeoCatalog.isUnidentified(it) }
            return GeoPoint(
                latitude = stale.latitude,
                longitude = stale.longitude,
                label = staleNeighborhood ?: rawAddress,
                geocoderMetadata = staleNeighborhood?.let { GeocoderPlaceMetadata(subLocality = it) }
            )
        }

        return null
    }

    private suspend fun geocodeInMontesClaros(rawAddress: String): GeoPoint? {
        geocoderOverride?.let { override ->
            return try {
                withTimeoutOrNull(GEOCODER_TIMEOUT_MS) { override(rawAddress) }
            } catch (e: CancellationException) {
                throw e
            } catch (_: Exception) {
                null
            }
        }

        if (!Geocoder.isPresent()) return null
        val query = if (rawAddress.contains("montes claros", ignoreCase = true)) {
            rawAddress
        } else {
            "$rawAddress, Montes Claros, MG, Brazil"
        }

        return try {
            withTimeoutOrNull(GEOCODER_TIMEOUT_MS) {
                val geocoder = Geocoder(context, Locale("pt", "BR"))
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    suspendCancellableCoroutine { cont ->
                        geocoder.getFromLocationName(
                            query,
                            1,
                            MontesClarosGeoCatalog.MIN_LAT,
                            MontesClarosGeoCatalog.MIN_LON,
                            MontesClarosGeoCatalog.MAX_LAT,
                            MontesClarosGeoCatalog.MAX_LON
                        ) { addresses ->
                            val addr = addresses.firstOrNull()
                            if (cont.isActive) {
                                cont.resume(addr?.toValidatedGeoPoint(rawAddress))
                            }
                        }
                    }
                } else {
                    @Suppress("DEPRECATION")
                    val list = geocoder.getFromLocationName(
                        query,
                        1,
                        MontesClarosGeoCatalog.MIN_LAT,
                        MontesClarosGeoCatalog.MIN_LON,
                        MontesClarosGeoCatalog.MAX_LAT,
                        MontesClarosGeoCatalog.MAX_LON
                    )
                    list?.firstOrNull()?.toValidatedGeoPoint(rawAddress)
                }
            }
        } catch (e: CancellationException) {
            throw e
        } catch (_: Exception) {
            null
        }
    }

    private fun Address.toValidatedGeoPoint(rawAddress: String): GeoPoint? {
        if (!MontesClarosGeoCatalog.isWithinMontesClarosBounds(latitude, longitude)) {
            return null
        }
        val metadata = GeocoderPlaceMetadata(
            subLocality = subLocality?.trim()?.takeIf { it.isNotBlank() },
            thoroughfare = thoroughfare?.trim()?.takeIf { it.isNotBlank() },
            featureName = featureName?.trim()?.takeIf { it.isNotBlank() },
            addressLine = getAddressLine(0)?.trim()?.takeIf { it.isNotBlank() },
            locality = locality?.trim()?.takeIf { it.isNotBlank() }
        )
        return GeoPoint(
            latitude = latitude,
            longitude = longitude,
            label = metadata.subLocality ?: rawAddress,
            geocoderMetadata = metadata
        )
    }

    private fun hasStreetOrNumberDetail(address: String): Boolean {
        val norm = MontesClarosGeoCatalog.normalize(address)
        return Regex("\\b(rua|r|av|avenida|travessa|tv|praca|alameda|rodovia|estrada)\\b").containsMatchIn(norm) ||
            Regex("\\b\\d{1,5}\\b").containsMatchIn(norm)
    }

    private fun buildRouteKey(
        currentLocation: GeoPoint,
        pickupPoint: GeoPoint,
        customerPoint: GeoPoint,
        centerPoint: GeoPoint,
        useOsrm: Boolean
    ): String {
        val mode = if (useOsrm) "OSRM" else "URBAN"
        return listOf(currentLocation, pickupPoint, customerPoint, centerPoint)
            .joinToString("|") { "${round4(it.latitude)},${round4(it.longitude)}" } + "|$mode"
    }

    private fun haversineKm(a: GeoPoint, b: GeoPoint): Double {
        val earthRadiusKm = 6371.0
        val dLat = Math.toRadians(b.latitude - a.latitude)
        val dLon = Math.toRadians(b.longitude - a.longitude)
        val lat1 = Math.toRadians(a.latitude)
        val lat2 = Math.toRadians(b.latitude)
        val h = sin(dLat / 2).pow(2) + cos(lat1) * cos(lat2) * sin(dLon / 2).pow(2)
        return 2 * earthRadiusKm * atan2(sqrt(h), sqrt(1 - h))
    }

    private fun round2(value: Double): Double = Math.round(value * 100.0) / 100.0
    private fun round4(value: Double): Double = Math.round(value * 10000.0) / 10000.0

    companion object {
        const val ROUTE_SOURCE_OSRM = "OSRM_REAL_ROADS"
        const val ROUTE_SOURCE_URBAN_FALLBACK = "ESTIMATED_URBAN"
        const val ADDRESS_SOURCE_GEOCODER = "GEOCODER"
        const val ADDRESS_SOURCE_CATALOG = "CATALOG"

        private const val GEOCODER_TIMEOUT_MS = 1800L
        private const val OSRM_REQUEST_TIMEOUT_MS = 3000L
        private const val GEOCODER_ADDRESS_TTL_MS = 30L * 24L * 60L * 60L * 1000L
        private const val CATALOG_ADDRESS_TTL_MS = 6L * 60L * 60L * 1000L
        private const val OSRM_ROUTE_TTL_MS = 7L * 24L * 60L * 60L * 1000L
        private const val FALLBACK_ROUTE_TTL_MS = 15L * 60L * 1000L
        private const val MAX_START_RADIUS_FROM_MOC_KM = 120.0
        private const val MAX_VALID_URBAN_ROUTE_KM = 250.0

        fun createDefaultOsrmApi(): OsrmRoutingApi {
            val moshi = Moshi.Builder()
                .addLast(KotlinJsonAdapterFactory())
                .build()

            val okHttpClient = OkHttpClient.Builder()
                .connectTimeout(2500, TimeUnit.MILLISECONDS)
                .readTimeout(2500, TimeUnit.MILLISECONDS)
                .callTimeout(3500, TimeUnit.MILLISECONDS)
                .connectionPool(ConnectionPool(4, 3, TimeUnit.MINUTES))
                .followRedirects(true)
                .retryOnConnectionFailure(true)
                .build()

            return Retrofit.Builder()
                .baseUrl("https://router.project-osrm.org/")
                .client(okHttpClient)
                .addConverterFactory(MoshiConverterFactory.create(moshi))
                .build()
                .create(OsrmRoutingApi::class.java)
        }
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/domain/OfferDecisionEngine.kt
package com.example.domain

import com.example.data.local.AnalyzedOfferEntity
import com.example.data.local.NeighborhoodRuleEntity
import com.example.data.local.NeighborhoodStatus
import com.example.data.local.OfferCaptureSource
import com.example.data.local.TrafficLightDecision
import com.example.data.preferences.DriverSettings
import java.util.Locale

object OfferDecisionEngine {

    fun evaluateOffer(
        source: OfferCaptureSource,
        rawSnippet: String,
        offerPriceBrl: Double,
        pickupAddress: String,
        customerAddress: String,
        route: RouteCalculationResult,
        usedGpsStart: Boolean,
        neighborhoodRules: List<NeighborhoodRuleEntity>,
        settings: DriverSettings
    ): AnalyzedOfferEntity {
        require(route.totalKm > 0.0 && route.totalKm.isFinite()) {
            "Distância total da rota inválida para avaliação."
        }
        val safeTotalKm = route.totalKm.coerceAtLeast(0.5)
        val earningsPerKm = Math.round((offerPriceBrl / safeTotalKm) * 100.0) / 100.0
        val target = settings.minTargetPerKm

        val pickupMatch = MontesClarosGeoCatalog.identifyNeighborhood(
            address = pickupAddress,
            point = route.pickupPoint,
            rules = neighborhoodRules
        )
        val customerMatch = MontesClarosGeoCatalog.identifyNeighborhood(
            address = customerAddress,
            point = route.customerPoint,
            rules = neighborhoodRules
        )

        val pickupRule = pickupMatch.rule
        val customerRule = customerMatch.rule
        val pickupLabel = pickupMatch.name
        val customerLabel = customerMatch.name

        val pickupAvoided = pickupRule?.status == NeighborhoodStatus.AVOIDED.name
        val customerAvoided = customerRule?.status == NeighborhoodStatus.AVOIDED.name
        val customerPreferred = customerRule?.status == NeighborhoodStatus.PREFERRED.name

        val avoidedDetails = buildList {
            if (customerAvoided) {
                val note = customerRule.notes.takeIf { it.isNotBlank() }?.let { " ($it)" } ?: ""
                add("Destino evitado: ${customerRule.name}$note")
            }
            if (pickupAvoided && pickupRule.name != customerRule?.name) {
                val note = pickupRule.notes.takeIf { it.isNotBlank() }?.let { " ($it)" } ?: ""
                add("Coleta evitada: ${pickupRule.name}$note")
            }
        }
        val neighborhoodAlert = avoidedDetails.joinToString(" • ").ifBlank { null }

        val unidentifiedSuffix = when {
            MontesClarosGeoCatalog.isUnidentified(customerLabel) &&
                MontesClarosGeoCatalog.isUnidentified(pickupLabel) ->
                " • Bairros de retirada e cliente não identificados"
            MontesClarosGeoCatalog.isUnidentified(customerLabel) ->
                " • Bairro do cliente não identificado"
            MontesClarosGeoCatalog.isUnidentified(pickupLabel) ->
                " • Bairro da loja não identificado"
            else -> ""
        }

        val routeSourceTag = if (route.routeSource == RouteCalculator.ROUTE_SOURCE_OSRM) {
            ""
        } else {
            " • Distância estimada"
        }

        val comfortMargin = target * 1.18
        val isLongReturn = route.leg3CustomerToCenterKm > settings.cautionReturnThresholdKm

        val (decision, reason) = when {
            customerAvoided || pickupAvoided -> {
                TrafficLightDecision.RED to "VERMELHO • NÃO COMPENSA: ${neighborhoodAlert ?: "Bairro evitado/perigoso"}"
            }
            earningsPerKm < target -> {
                val formattedRate = formatBrl(earningsPerKm)
                val formattedTarget = formatBrl(target)
                TrafficLightDecision.RED to "VERMELHO • NÃO COMPENSA: $formattedRate/km abaixo da meta mínima de $formattedTarget/km$unidentifiedSuffix$routeSourceTag"
            }
            earningsPerKm < comfortMargin && !customerPreferred -> {
                val formattedRate = formatBrl(earningsPerKm)
                TrafficLightDecision.YELLOW to "AMARELO • ATENÇÃO: Margem apertada ($formattedRate/km) considerando retorno ao Centro (${route.leg3CustomerToCenterKm} km)$unidentifiedSuffix$routeSourceTag"
            }
            isLongReturn -> {
                TrafficLightDecision.YELLOW to "AMARELO • ATENÇÃO: Retorno longo até o Centro (${route.leg3CustomerToCenterKm} km)$unidentifiedSuffix$routeSourceTag"
            }
            else -> {
                val formattedRate = formatBrl(earningsPerKm)
                val bonusTag = if (customerPreferred) " • Bairro preferido ($customerLabel)" else ""
                TrafficLightDecision.GREEN to "VERDE • COMPENSA: $formattedRate/km acima da meta$bonusTag$unidentifiedSuffix$routeSourceTag"
            }
        }

        return AnalyzedOfferEntity(
            timestamp = System.currentTimeMillis(),
            source = source.name,
            rawSnippet = rawSnippet,
            offerPriceBrl = offerPriceBrl,
            pickupAddress = pickupAddress,
            pickupNeighborhood = pickupLabel,
            customerAddress = customerAddress,
            customerNeighborhood = customerLabel,
            leg1CurrentToPickupKm = route.leg1CurrentToPickupKm,
            leg2PickupToCustomerKm = route.leg2PickupToCustomerKm,
            leg3CustomerToCenterKm = route.leg3CustomerToCenterKm,
            totalKm = route.totalKm,
            earningsPerKm = earningsPerKm,
            targetPerKm = target,
            decision = decision.name,
            decisionReason = reason,
            neighborhoodAlert = neighborhoodAlert,
            routeSource = route.routeSource,
            usedGpsStart = usedGpsStart
        )
    }

    private fun formatBrl(value: Double): String =
        String.format(Locale("pt", "BR"), "R$ %.2f", value)
}
EOF

cat << 'EOF' > app/src/main/java/com/example/domain/OfferAnalysisCoordinator.kt
package com.example.domain

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import com.example.data.OfferRepository
import com.example.data.local.AnalyzedOfferEntity
import com.example.data.local.OfferCaptureSource
import com.example.data.preferences.DriverPreferencesRepository
import com.example.service.FloatingOverlayService
import com.example.service.ServiceRuntimeBus
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock

sealed class OfferAnalysisOutcome {
    data class Success(val offer: AnalyzedOfferEntity) : OfferAnalysisOutcome()
    data class Unresolved(val reason: String) : OfferAnalysisOutcome()
    data class Error(val reason: String) : OfferAnalysisOutcome()
}

class OfferAnalysisCoordinator(
    private val context: Context,
    private val offerRepository: OfferRepository,
    private val preferencesRepository: DriverPreferencesRepository,
    private val locationHelper: LocationHelper,
    private val routeCalculator: RouteCalculator,
    private val ocrProcessor: OcrFallbackProcessor
) {
    private val coordinatorScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private val dispatchMutex = Mutex()
    private var activeRunId: Long = 0L
    private var activeSignature: String? = null
    private var activeDeferred: Deferred<OfferAnalysisOutcome>? = null

    suspend fun analyzeStructuredOffer(
        priceBrl: Double,
        pickupAddress: String,
        customerAddress: String,
        source: OfferCaptureSource,
        rawSnippet: String = "",
        detectedPackage: String = ""
    ): OfferAnalysisOutcome {
        val cleanPickup = pickupAddress.trim()
        val cleanCustomer = customerAddress.trim()
        val signature = buildOfferSignature(priceBrl, cleanPickup, cleanCustomer)

        val (runId, deferredToAwait) = dispatchMutex.withLock {
            val currentDeferred = activeDeferred
            if (currentDeferred != null && currentDeferred.isActive && activeSignature == signature) {
                return@withLock activeRunId to currentDeferred
            }

            currentDeferred?.cancel(CancellationException("Nova oferta recebida"))

            val nextRunId = ServiceRuntimeBus.nextRunId()
            ServiceRuntimeBus.beginRun(
                runId = nextRunId,
                message = "Calculando rota até o Centro de Montes Claros...",
                detectedPackage = detectedPackage
            )

            val newDeferred = coordinatorScope.async {
                executeOfferAnalysis(
                    runId = nextRunId,
                    priceBrl = priceBrl,
                    pickupAddress = cleanPickup,
                    customerAddress = cleanCustomer,
                    source = source,
                    rawSnippet = rawSnippet,
                    detectedPackage = detectedPackage
                )
            }

            activeRunId = nextRunId
            activeSignature = signature
            activeDeferred = newDeferred

            newDeferred.invokeOnCompletion {
                coordinatorScope.launch {
                    dispatchMutex.withLock {
                        if (activeRunId == nextRunId && activeDeferred === newDeferred) {
                            activeDeferred = null
                            activeSignature = null
                        }
                    }
                }
            }

            nextRunId to newDeferred
        }

        return try {
            deferredToAwait.await()
        } catch (e: CancellationException) {
            throw e
        } catch (e: Exception) {
            val msg = "Falha inesperada na análise: ${e.message ?: "erro interno"}"
            ServiceRuntimeBus.failRun(runId, msg, detectedPackage)
            OfferAnalysisOutcome.Error(msg)
        }
    }

    private suspend fun executeOfferAnalysis(
        runId: Long,
        priceBrl: Double,
        pickupAddress: String,
        customerAddress: String,
        source: OfferCaptureSource,
        rawSnippet: String,
        detectedPackage: String
    ): OfferAnalysisOutcome {
        return try {
            val settings = preferencesRepository.getSettingsOnce()
            val rules = offerRepository.getNeighborhoodRulesOnce()
            val driverLocation = locationHelper.getCurrentLocationOrFallback()

            if (!ServiceRuntimeBus.isRunCurrent(runId)) {
                throw CancellationException("Execução substituída por oferta mais recente")
            }

            when (
                val routeResolution = routeCalculator.calculateCompleteRoute(
                    currentLocation = driverLocation.point,
                    pickupAddress = pickupAddress,
                    customerAddress = customerAddress,
                    useOsrmRoadRouting = settings.useOsrmRoadRouting
                )
            ) {
                is RouteResolutionResult.UnresolvedAddress -> {
                    ServiceRuntimeBus.failRun(
                        runId = runId,
                        errorMessage = routeResolution.reason,
                        detectedPackage = detectedPackage
                    )
                    if (settings.autoShowOverlayOnOffer && Settings.canDrawOverlays(context)) {
                        startOrUpdateOverlay(context)
                    }
                    OfferAnalysisOutcome.Unresolved(routeResolution.reason)
                }

                is RouteResolutionResult.Resolved -> {
                    if (!ServiceRuntimeBus.isRunCurrent(runId)) {
                        throw CancellationException("Execução substituída por oferta mais recente")
                    }

                    val evaluated = OfferDecisionEngine.evaluateOffer(
                        source = source,
                        rawSnippet = rawSnippet.ifBlank {
                            "Valor: R$ $priceBrl | Retirada: $pickupAddress | Entrega: $customerAddress"
                        },
                        offerPriceBrl = priceBrl,
                        pickupAddress = pickupAddress,
                        customerAddress = customerAddress,
                        route = routeResolution.route,
                        usedGpsStart = driverLocation.usedGps,
                        neighborhoodRules = rules,
                        settings = settings
                    )

                    val insertedId = offerRepository.saveAnalyzedOffer(evaluated)
                    val savedOffer = evaluated.copy(id = insertedId)
                    ServiceRuntimeBus.completeRun(runId, savedOffer, detectedPackage)

                    if (settings.autoShowOverlayOnOffer && Settings.canDrawOverlays(context)) {
                        startOrUpdateOverlay(context)
                    }
                    OfferAnalysisOutcome.Success(savedOffer)
                }
            }
        } catch (e: CancellationException) {
            throw e
        } catch (e: Exception) {
            val errorMsg = "Erro ao calcular rota: ${e.message ?: "verifique a conexão"}"
            ServiceRuntimeBus.failRun(runId, errorMsg, detectedPackage)
            OfferAnalysisOutcome.Error(errorMsg)
        }
    }

    suspend fun analyzeFromOcrImageUri(uri: Uri): OfferAnalysisOutcome {
        val runId = dispatchMutex.withLock {
            activeDeferred?.cancel(CancellationException("Nova leitura OCR solicitada"))
            activeDeferred = null
            activeSignature = null
            val nextId = ServiceRuntimeBus.nextRunId()
            activeRunId = nextId
            ServiceRuntimeBus.beginRun(nextId, "Executando OCR (ML Kit) na imagem selecionada...")
            nextId
        }

        return try {
            val extractedText = ocrProcessor.extractTextFromUri(context, uri)
            if (!ServiceRuntimeBus.isRunCurrent(runId)) {
                return OfferAnalysisOutcome.Error("Leitura OCR descartada porque uma nova oferta chegou.")
            }

            val parsed = OfferParser.parse(extractedText, requireDeliveryKeywords = false)
            if (parsed == null) {
                val msg = "Não foi possível identificar valor (R$) e endereços válidos na imagem."
                ServiceRuntimeBus.failRun(runId, msg)
                OfferAnalysisOutcome.Error(msg)
            } else {
                analyzeStructuredOffer(
                    priceBrl = parsed.offerPriceBrl,
                    pickupAddress = parsed.pickupAddress,
                    customerAddress = parsed.customerAddress,
                    source = OfferCaptureSource.OCR_IMAGE,
                    rawSnippet = parsed.rawSnippet
                )
            }
        } catch (e: CancellationException) {
            throw e
        } catch (e: Exception) {
            val msg = "Falha no OCR: ${e.message ?: "erro ao ler imagem"}"
            ServiceRuntimeBus.failRun(runId, msg)
            OfferAnalysisOutcome.Error(msg)
        }
    }

    private fun buildOfferSignature(
        priceBrl: Double,
        pickupAddress: String,
        customerAddress: String
    ): String {
        val normPickup = MontesClarosGeoCatalog.normalizeAddressCacheKey(pickupAddress)
        val normCustomer = MontesClarosGeoCatalog.normalizeAddressCacheKey(customerAddress)
        val roundedPrice = Math.round(priceBrl * 100.0)
        return "$roundedPrice|$normPickup|$normCustomer"
    }

    companion object {
        fun startOrUpdateOverlay(context: Context) {
            if (!Settings.canDrawOverlays(context)) return
            val intent = Intent(context, FloatingOverlayService::class.java).apply {
                action = FloatingOverlayService.ACTION_SHOW_OR_UPDATE
            }
            try {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    context.startForegroundService(intent)
                } else {
                    context.startService(intent)
                }
            } catch (_: Exception) {
            }
        }

        fun stopOverlay(context: Context) {
            val intent = Intent(context, FloatingOverlayService::class.java).apply {
                action = FloatingOverlayService.ACTION_STOP
            }
            try {
                context.startService(intent)
            } catch (_: Exception) {
            }
        }
    }
}
EOF
cat << 'EOF' > app/src/main/java/com/example/service/ServiceRuntimeBus.kt
package com.example.service

import com.example.data.local.AnalyzedOfferEntity
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import java.util.concurrent.atomic.AtomicLong

data class ServiceRuntimeState(
    val activeRunId: Long = 0L,
    val isAccessibilityConnected: Boolean = false,
    val isOverlayServiceRunning: Boolean = false,
    val isAnalyzing: Boolean = false,
    val lastDetectedPackage: String = "",
    val lastCaptureMethod: String = "Aguardando oferta",
    val lastDetectionTimestamp: Long? = null,
    val lastOcrFallbackTimestamp: Long? = null,
    val latestOffer: AnalyzedOfferEntity? = null,
    val lastAnalysisError: String? = null,
    val lastStatusMessage: String = "Serviços prontos para monitoramento"
)

object ServiceRuntimeBus {
    private val runIdGenerator = AtomicLong(0L)
    private val _state = MutableStateFlow(ServiceRuntimeState())
    val state: StateFlow<ServiceRuntimeState> = _state.asStateFlow()

    private val _manualOcrTrigger = MutableSharedFlow<Unit>(extraBufferCapacity = 2)
    val manualOcrTrigger: SharedFlow<Unit> = _manualOcrTrigger.asSharedFlow()

    fun nextRunId(): Long = runIdGenerator.incrementAndGet()

    fun isRunCurrent(runId: Long): Boolean = runId >= _state.value.activeRunId

    fun setAccessibilityConnected(connected: Boolean) {
        _state.update {
            it.copy(
                isAccessibilityConnected = connected,
                lastStatusMessage = if (connected) {
                    "Acessibilidade conectada ao leitor Mob Lets"
                } else {
                    "Acessibilidade desconectada"
                }
            )
        }
    }

    fun setOverlayServiceRunning(running: Boolean) {
        _state.update { it.copy(isOverlayServiceRunning = running) }
    }

    fun beginRun(runId: Long, message: String, detectedPackage: String = "") {
        _state.update { current ->
            if (runId < current.activeRunId) return@update current
            current.copy(
                activeRunId = runId,
                isAnalyzing = true,
                latestOffer = null,
                lastAnalysisError = null,
                lastDetectedPackage = detectedPackage.ifBlank { current.lastDetectedPackage },
                lastStatusMessage = message
            )
        }
    }

    fun completeRun(runId: Long, offer: AnalyzedOfferEntity, detectedPackage: String = "") {
        _state.update { current ->
            if (runId < current.activeRunId) return@update current
            current.copy(
                activeRunId = runId,
                isAnalyzing = false,
                latestOffer = offer,
                lastAnalysisError = null,
                lastDetectedPackage = detectedPackage.ifBlank { current.lastDetectedPackage },
                lastCaptureMethod = offer.source,
                lastDetectionTimestamp = offer.timestamp,
                lastOcrFallbackTimestamp = if (offer.source.startsWith("OCR")) offer.timestamp else current.lastOcrFallbackTimestamp,
                lastStatusMessage = offer.decisionReason
            )
        }
    }

    fun failRun(runId: Long, errorMessage: String, detectedPackage: String = "") {
        _state.update { current ->
            if (runId < current.activeRunId) return@update current
            current.copy(
                activeRunId = runId,
                isAnalyzing = false,
                latestOffer = null,
                lastAnalysisError = errorMessage,
                lastDetectedPackage = detectedPackage.ifBlank { current.lastDetectedPackage },
                lastStatusMessage = errorMessage
            )
        }
    }

    fun clearLatestOffer() {
        _state.update {
            it.copy(
                isAnalyzing = false,
                latestOffer = null,
                lastAnalysisError = null,
                lastStatusMessage = if (it.isAccessibilityConnected) {
                    "Aguardando nova oferta do Mob Lets..."
                } else {
                    "Serviços prontos para monitoramento"
                }
            )
        }
    }

    fun setAnalyzing(analyzing: Boolean, message: String? = null) {
        _state.update {
            it.copy(
                isAnalyzing = analyzing,
                lastAnalysisError = if (analyzing) null else it.lastAnalysisError,
                lastStatusMessage = message ?: it.lastStatusMessage
            )
        }
    }

    fun onOfferAnalyzed(offer: AnalyzedOfferEntity, detectedPackage: String = "") {
        val runId = nextRunId()
        completeRun(runId, offer, detectedPackage)
    }

    fun updateStatusMessage(message: String, detectedPackage: String? = null) {
        _state.update {
            it.copy(
                lastStatusMessage = message,
                lastDetectedPackage = detectedPackage ?: it.lastDetectedPackage
            )
        }
    }

    fun requestImmediateScreenOcr() {
        _manualOcrTrigger.tryEmit(Unit)
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/service/MobLetsAccessibilityService.kt
package com.example.service

import android.accessibilityservice.AccessibilityService
import android.graphics.Bitmap
import android.os.Build
import android.view.Display
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo
import com.example.RotaInteligenteApp
import com.example.data.local.OfferCaptureSource
import com.example.domain.MontesClarosGeoCatalog
import com.example.domain.OfferParser
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch
import java.util.concurrent.atomic.AtomicBoolean

class MobLetsAccessibilityService : AccessibilityService() {

    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.Default)
    private val isOcrInFlight = AtomicBoolean(false)

    @Volatile
    private var activeEventJob: Job? = null

    @Volatile
    private var lastEventScanMs = 0L

    @Volatile
    private var lastOcrScanMs = 0L

    @Volatile
    private var lastActiveOfferSignature = ""

    @Volatile
    private var lastOfferScreenVisibleMs = 0L

    @Volatile
    private var lastScreenFingerprint = ""

    @Volatile
    private var lastNonOfferScreenStartMs = 0L

    private val ignoredPackages = setOf(
        "com.android.systemui",
        "com.google.android.inputmethod.latin",
        "com.android.settings"
    )

    private val timerNoiseRegex = Regex("""\b\d{1,2}\s?(?:s|seg|min)\b|\b\d{1,2}:\d{2}\b""", RegexOption.IGNORE_CASE)

    override fun onServiceConnected() {
        super.onServiceConnected()
        ServiceRuntimeBus.setAccessibilityConnected(true)

        serviceScope.launch {
            ServiceRuntimeBus.manualOcrTrigger.collectLatest {
                triggerOcrFallbackScan(
                    detectedPackage = ServiceRuntimeBus.state.value.lastDetectedPackage.ifBlank { "ocr.manual" },
                    requireKeywords = false
                )
            }
        }
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        val pkg = event?.packageName?.toString().orEmpty()
        if (pkg.isBlank() || pkg == packageName || pkg in ignoredPackages) return

        val now = System.currentTimeMillis()
        if (now - lastEventScanMs < 750L) return
        lastEventScanMs = now

        val app = application as? RotaInteligenteApp ?: return
        val coordinator = app.container.analysisCoordinator
        val prefs = app.container.preferencesRepository

        val extractedText = collectWindowTextSafely()
        val fingerprint = normalizeScreenFingerprint(pkg, extractedText)
        val sameVisualScreen = fingerprint.isNotBlank() && fingerprint == lastScreenFingerprint

        val isMobLetsPackage = pkg.contains("moblets", ignoreCase = true) ||
            pkg.contains("mob.lets", ignoreCase = true) ||
            pkg.contains("mob_lets", ignoreCase = true)

        val parsedFromAccessibility = OfferParser.parse(
            rawText = extractedText,
            requireDeliveryKeywords = !isMobLetsPackage
        )

        if (parsedFromAccessibility != null) {
            lastOfferScreenVisibleMs = now
            lastNonOfferScreenStartMs = 0L
            lastScreenFingerprint = fingerprint

            val signature = buildSignature(
                parsedFromAccessibility.offerPriceBrl,
                parsedFromAccessibility.pickupAddress,
                parsedFromAccessibility.customerAddress
            )

            if (signature == lastActiveOfferSignature) {
                return
            }

            lastActiveOfferSignature = signature
            activeEventJob?.cancel()
            activeEventJob = serviceScope.launch {
                try {
                    val settings = prefs.getSettingsOnce()
                    if (settings.strictMobLetsPackageFilter && !isMobLetsPackage) {
                        return@launch
                    }
                    coordinator.analyzeStructuredOffer(
                        priceBrl = parsedFromAccessibility.offerPriceBrl,
                        pickupAddress = parsedFromAccessibility.pickupAddress,
                        customerAddress = parsedFromAccessibility.customerAddress,
                        source = OfferCaptureSource.ACCESSIBILITY,
                        rawSnippet = parsedFromAccessibility.rawSnippet,
                        detectedPackage = pkg
                    )
                } catch (e: CancellationException) {
                    throw e
                } catch (e: Exception) {
                    ServiceRuntimeBus.updateStatusMessage(
                        "Erro na leitura de tela: ${e.message ?: "tentando novamente"}",
                        pkg
                    )
                }
            }
            return
        }

        if (extractedText.length >= 40) {
            if (lastNonOfferScreenStartMs == 0L) {
                lastNonOfferScreenStartMs = now
            } else if (lastActiveOfferSignature.isNotBlank() &&
                (now - lastNonOfferScreenStartMs) >= OFFER_LEAVE_CONFIRMATION_MS
            ) {
                lastActiveOfferSignature = ""
            }
        }

        if (sameVisualScreen) return
        lastScreenFingerprint = fingerprint

        if (now - lastOcrScanMs < 4000L || isOcrInFlight.get()) return

        serviceScope.launch {
            try {
                val settings = prefs.getSettingsOnce()
                if (settings.strictMobLetsPackageFilter && !isMobLetsPackage) return@launch
                if (settings.ocrFallbackEnabled && (isMobLetsPackage || extractedText.length < 35)) {
                    lastOcrScanMs = System.currentTimeMillis()
                    triggerOcrFallbackScan(
                        detectedPackage = pkg,
                        requireKeywords = !isMobLetsPackage
                    )
                }
            } catch (e: CancellationException) {
                throw e
            } catch (_: Exception) {
            }
        }
    }

    private fun triggerOcrFallbackScan(detectedPackage: String, requireKeywords: Boolean) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) {
            ServiceRuntimeBus.updateStatusMessage(
                "Fallback OCR automático requer Android 11+ (use o leitor de print no painel).",
                detectedPackage
            )
            return
        }

        if (!isOcrInFlight.compareAndSet(false, true)) return

        val app = application as? RotaInteligenteApp ?: run {
            isOcrInFlight.set(false)
            return
        }

        try {
            takeScreenshot(
                Display.DEFAULT_DISPLAY,
                mainExecutor,
                object : TakeScreenshotCallback {
                    override fun onSuccess(screenshot: ScreenshotResult) {
                        var softwareBitmap: Bitmap? = null
                        try {
                            val hardwareBuffer = screenshot.hardwareBuffer
                            val colorSpace = screenshot.colorSpace
                            val hwBitmap = try {
                                Bitmap.wrapHardwareBuffer(hardwareBuffer, colorSpace)
                            } finally {
                                hardwareBuffer.close()
                            }

                            if (hwBitmap == null) {
                                isOcrInFlight.set(false)
                                return
                            }
                            softwareBitmap = try {
                                hwBitmap.copy(Bitmap.Config.ARGB_8888, false)
                            } finally {
                                hwBitmap.recycle()
                            }
                        } catch (_: Exception) {
                            softwareBitmap?.recycle()
                            isOcrInFlight.set(false)
                            return
                        }

                        val capturedBitmap = softwareBitmap
                        if (capturedBitmap == null) {
                            isOcrInFlight.set(false)
                            return
                        }

                        serviceScope.launch {
                            try {
                                val ocrText = try {
                                    app.container.ocrProcessor.extractTextFromBitmap(capturedBitmap)
                                } finally {
                                    if (!capturedBitmap.isRecycled) {
                                        capturedBitmap.recycle()
                                    }
                                }

                                val parsed = OfferParser.parse(
                                    rawText = ocrText,
                                    requireDeliveryKeywords = requireKeywords
                                ) ?: return@launch

                                val signature = buildSignature(
                                    parsed.offerPriceBrl,
                                    parsed.pickupAddress,
                                    parsed.customerAddress
                                )
                                if (signature == lastActiveOfferSignature) return@launch

                                lastActiveOfferSignature = signature
                                lastOfferScreenVisibleMs = System.currentTimeMillis()
                                lastNonOfferScreenStartMs = 0L

                                app.container.analysisCoordinator.analyzeStructuredOffer(
                                    priceBrl = parsed.offerPriceBrl,
                                    pickupAddress = parsed.pickupAddress,
                                    customerAddress = parsed.customerAddress,
                                    source = OfferCaptureSource.OCR_SCREENSHOT,
                                    rawSnippet = parsed.rawSnippet,
                                    detectedPackage = detectedPackage
                                )
                            } catch (e: CancellationException) {
                                throw e
                            } catch (_: Exception) {
                            } finally {
                                isOcrInFlight.set(false)
                            }
                        }
                    }

                    override fun onFailure(errorCode: Int) {
                        isOcrInFlight.set(false)
                        ServiceRuntimeBus.updateStatusMessage(
                            "Captura OCR indisponível neste quadro (código $errorCode)",
                            detectedPackage
                        )
                    }
                }
            )
        } catch (_: Exception) {
            isOcrInFlight.set(false)
        }
    }

    private fun normalizeScreenFingerprint(pkg: String, text: String): String {
        if (text.isBlank()) return ""
        val withoutTimers = text.replace(timerNoiseRegex, " ")
        return "$pkg|${MontesClarosGeoCatalog.normalize(withoutTimers).take(300)}"
    }

    private fun buildSignature(priceBrl: Double, pickup: String, customer: String): String {
        val normP = MontesClarosGeoCatalog.normalizeAddressCacheKey(pickup)
        val normC = MontesClarosGeoCatalog.normalizeAddressCacheKey(customer)
        return "${Math.round(priceBrl * 100.0)}|$normP|$normC"
    }

    private fun collectWindowTextSafely(): String {
        val root = try {
            rootInActiveWindow
        } catch (_: Exception) {
            null
        } ?: return ""

        return try {
            collectNodeText(root)
        } finally {
            try {
                @Suppress("DEPRECATION")
                root.recycle()
            } catch (_: Exception) {
            }
        }
    }

    private fun collectNodeText(
        node: AccessibilityNodeInfo?,
        depth: Int = 0,
        builder: StringBuilder = StringBuilder()
    ): String {
        if (node == null || depth > 24 || builder.length > 4000) return builder.toString()

        val text = node.text?.toString()?.trim()
        if (!text.isNullOrBlank()) {
            builder.append(text).append('\n')
        } else {
            val desc = node.contentDescription?.toString()?.trim()
            if (!desc.isNullOrBlank()) {
                builder.append(desc).append('\n')
            }
        }

        val childCount = node.childCount
        for (i in 0 until childCount) {
            val child = node.getChild(i) ?: continue
            try {
                collectNodeText(child, depth + 1, builder)
            } finally {
                try {
                    @Suppress("DEPRECATION")
                    child.recycle()
                } catch (_: Exception) {
                }
            }
        }
        return builder.toString()
    }

    override fun onInterrupt() {
        activeEventJob?.cancel()
        isOcrInFlight.set(false)
        ServiceRuntimeBus.setAccessibilityConnected(false)
    }

    override fun onDestroy() {
        super.onDestroy()
        activeEventJob?.cancel()
        isOcrInFlight.set(false)
        serviceScope.cancel()
        ServiceRuntimeBus.setAccessibilityConnected(false)
    }

    companion object {
        private const val OFFER_LEAVE_CONFIRMATION_MS = 2500L
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/service/FloatingOverlayService.kt
package com.example.service

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.graphics.Color
import android.graphics.PixelFormat
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.os.IBinder
import android.provider.Settings
import android.text.TextUtils
import android.view.Gravity
import android.view.MotionEvent
import android.view.View
import android.view.WindowManager
import android.widget.LinearLayout
import android.widget.TextView
import androidx.core.app.NotificationCompat
import com.example.MainActivity
import com.example.R
import com.example.data.local.TrafficLightDecision
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch
import java.util.Locale
import kotlin.math.abs

class FloatingOverlayService : Service() {

    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.Main.immediate)
    private var windowManager: WindowManager? = null
    private var overlayRoot: LinearLayout? = null
    private var layoutParams: WindowManager.LayoutParams? = null
    private var isExpanded = true

    private lateinit var headerContainer: LinearLayout
    private lateinit var decisionDotView: View
    private lateinit var decisionTitleView: TextView
    private lateinit var rateMetricView: TextView
    private lateinit var expandToggleView: TextView
    private lateinit var detailsContainer: LinearLayout
    private lateinit var offerSummaryView: TextView
    private lateinit var routeBreakdownView: TextView
    private lateinit var alertBannerView: TextView
    private lateinit var footerRow: LinearLayout

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
        startForeground(NOTIFICATION_ID, buildNotification())
        ServiceRuntimeBus.setOverlayServiceRunning(true)

        if (Settings.canDrawOverlays(this)) {
            attachOverlayWindow()
        }

        serviceScope.launch {
            ServiceRuntimeBus.state.collectLatest { runtime ->
                renderState(runtime)
            }
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_STOP -> {
                stopSelf()
                return START_NOT_STICKY
            }
            ACTION_SHOW_OR_UPDATE -> {
                if (overlayRoot == null && Settings.canDrawOverlays(this)) {
                    attachOverlayWindow()
                }
                renderState(ServiceRuntimeBus.state.value)
            }
        }
        return START_STICKY
    }

    private fun attachOverlayWindow() {
        if (overlayRoot != null) return
        windowManager = getSystemService(WINDOW_SERVICE) as WindowManager

        val overlayType = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
        } else {
            @Suppress("DEPRECATION")
            WindowManager.LayoutParams.TYPE_PHONE
        }

        val params = WindowManager.LayoutParams(
            dp(304),
            WindowManager.LayoutParams.WRAP_CONTENT,
            overlayType,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN,
            PixelFormat.TRANSLUCENT
        ).apply {
            gravity = Gravity.TOP or Gravity.START
            x = dp(16)
            y = dp(96)
        }
        layoutParams = params

        val root = buildOverlayView()
        overlayRoot = root
        try {
            windowManager?.addView(root, params)
        } catch (_: Exception) {
            overlayRoot = null
        }
    }

    private fun buildOverlayView(): LinearLayout {
        val cardBg = GradientDrawable().apply {
            setColor(Color.parseColor("#F00B1220"))
            cornerRadius = dp(18).toFloat()
            setStroke(dp(1), Color.parseColor("#334155"))
        }

        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            background = cardBg
            setPadding(dp(12), dp(10), dp(12), dp(10))
            elevation = dp(12).toFloat()
        }

        headerContainer = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL
        }

        decisionDotView = View(this).apply {
            layoutParams = LinearLayout.LayoutParams(dp(12), dp(12)).apply {
                marginEnd = dp(8)
            }
            background = circleDrawable(Color.parseColor("#38BDF8"))
        }

        val titleCol = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            layoutParams = LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f)
        }

        decisionTitleView = TextView(this).apply {
            text = "ROTA INTELIGENTE IA"
            setTextColor(Color.WHITE)
            textSize = 12f
            typeface = Typeface.DEFAULT_BOLD
            maxLines = 1
            ellipsize = TextUtils.TruncateAt.END
        }

        rateMetricView = TextView(this).apply {
            text = "Aguardando oferta Mob Lets..."
            setTextColor(Color.parseColor("#94A3B8"))
            textSize = 11f
            maxLines = 1
            ellipsize = TextUtils.TruncateAt.END
        }

        titleCol.addView(decisionTitleView)
        titleCol.addView(rateMetricView)

        expandToggleView = TextView(this).apply {
            text = "–"
            setTextColor(Color.parseColor("#CBD5E1"))
            textSize = 16f
            typeface = Typeface.DEFAULT_BOLD
            setPadding(dp(10), dp(4), dp(10), dp(4))
            setOnClickListener {
                isExpanded = !isExpanded
                detailsContainer.visibility = if (isExpanded) View.VISIBLE else View.GONE
                footerRow.visibility = if (isExpanded) View.VISIBLE else View.GONE
                text = if (isExpanded) "–" else "+"
            }
        }

        val closeBtn = TextView(this).apply {
            text = "✕"
            setTextColor(Color.parseColor("#F87171"))
            textSize = 14f
            typeface = Typeface.DEFAULT_BOLD
            setPadding(dp(8), dp(4), dp(4), dp(4))
            setOnClickListener { stopSelf() }
        }

        headerContainer.addView(decisionDotView)
        headerContainer.addView(titleCol)
        headerContainer.addView(expandToggleView)
        headerContainer.addView(closeBtn)

        var initialX = 0
        var initialY = 0
        var initialTouchX = 0f
        var initialTouchY = 0f
        var moved = false
        headerContainer.setOnTouchListener { _, event ->
            val lp = layoutParams ?: return@setOnTouchListener false
            val rootView = overlayRoot ?: return@setOnTouchListener false
            when (event.action) {
                MotionEvent.ACTION_DOWN -> {
                    initialX = lp.x
                    initialY = lp.y
                    initialTouchX = event.rawX
                    initialTouchY = event.rawY
                    moved = false
                    true
                }
                MotionEvent.ACTION_MOVE -> {
                    val dx = (event.rawX - initialTouchX).toInt()
                    val dy = (event.rawY - initialTouchY).toInt()
                    if (abs(dx) > 4 || abs(dy) > 4) moved = true
                    lp.x = initialX + dx
                    lp.y = initialY + dy
                    try {
                        windowManager?.updateViewLayout(rootView, lp)
                    } catch (_: Exception) {
                    }
                    true
                }
                MotionEvent.ACTION_UP -> moved
                else -> false
            }
        }

        detailsContainer = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(0, dp(8), 0, dp(6))
        }

        offerSummaryView = TextView(this).apply {
            text = "Abra o Mob Lets para leitura automática via Acessibilidade ou OCR."
            setTextColor(Color.parseColor("#E2E8F0"))
            textSize = 12f
            setLineSpacing(dp(2).toFloat(), 1f)
        }

        routeBreakdownView = TextView(this).apply {
            text = "Etapas: Atual → Loja → Cliente → Centro MOC"
            setTextColor(Color.parseColor("#38BDF8"))
            textSize = 11f
            setPadding(0, dp(4), 0, 0)
        }

        alertBannerView = TextView(this).apply {
            visibility = View.GONE
            setTextColor(Color.parseColor("#FECACA"))
            textSize = 11f
            typeface = Typeface.DEFAULT_BOLD
            setPadding(dp(8), dp(6), dp(8), dp(6))
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#7F1D1D"))
                cornerRadius = dp(10).toFloat()
            }
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                topMargin = dp(6)
            }
        }

        detailsContainer.addView(offerSummaryView)
        detailsContainer.addView(routeBreakdownView)
        detailsContainer.addView(alertBannerView)

        footerRow = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.END
            setPadding(0, dp(4), 0, 0)
        }

        val ocrBtn = TextView(this).apply {
            text = "OCR Tela"
            setTextColor(Color.parseColor("#BAE6FD"))
            textSize = 11f
            typeface = Typeface.DEFAULT_BOLD
            setPadding(dp(10), dp(6), dp(10), dp(6))
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#0C4A6E"))
                cornerRadius = dp(10).toFloat()
            }
            setOnClickListener {
                ServiceRuntimeBus.requestImmediateScreenOcr()
            }
        }

        val openAppBtn = TextView(this).apply {
            text = "Abrir Painel"
            setTextColor(Color.WHITE)
            textSize = 11f
            typeface = Typeface.DEFAULT_BOLD
            setPadding(dp(10), dp(6), dp(10), dp(6))
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#1E293B"))
                cornerRadius = dp(10).toFloat()
            }
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                marginStart = dp(8)
            }
            setOnClickListener {
                val launch = Intent(this@FloatingOverlayService, MainActivity::class.java).apply {
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP)
                }
                startActivity(launch)
            }
        }

        footerRow.addView(ocrBtn)
        footerRow.addView(openAppBtn)

        root.addView(headerContainer)
        root.addView(detailsContainer)
        root.addView(footerRow)
        return root
    }

    private fun renderState(runtime: ServiceRuntimeState) {
        if (overlayRoot == null) return

        if (runtime.isAnalyzing) {
            (overlayRoot?.background as? GradientDrawable)?.setStroke(dp(2), Color.parseColor("#38BDF8"))
            decisionDotView.background = circleDrawable(Color.parseColor("#38BDF8"))
            decisionTitleView.text = "ANALISANDO NOVA OFERTA..."
            decisionTitleView.setTextColor(Color.parseColor("#38BDF8"))
            rateMetricView.text = "Consultando cache / vias em Montes Claros"
            offerSummaryView.text = runtime.lastStatusMessage
            routeBreakdownView.text = "Etapas: Atual → Loja → Cliente → Centro MOC"
            alertBannerView.visibility = View.GONE
            return
        }

        if (!runtime.lastAnalysisError.isNullOrBlank()) {
            (overlayRoot?.background as? GradientDrawable)?.setStroke(dp(2), Color.parseColor("#F59E0B"))
            decisionDotView.background = circleDrawable(Color.parseColor("#F59E0B"))
            decisionTitleView.text = "ENDEREÇO NÃO LOCALIZADO"
            decisionTitleView.setTextColor(Color.parseColor("#F59E0B"))
            rateMetricView.text = "Sem cálculo falso • Confira no Painel"
            offerSummaryView.text = runtime.lastAnalysisError
            routeBreakdownView.text = "Nenhum km estimado artificialmente"
            alertBannerView.visibility = View.VISIBLE
            (alertBannerView.background as? GradientDrawable)?.setColor(Color.parseColor("#78350F"))
            alertBannerView.setTextColor(Color.parseColor("#FDE68A"))
            alertBannerView.text = "⚠ Endereço fora do catálogo/Geocoder de Montes Claros"
            return
        }

        val offer = runtime.latestOffer
        if (offer == null) {
            (overlayRoot?.background as? GradientDrawable)?.setStroke(dp(1), Color.parseColor("#334155"))
            decisionDotView.background = circleDrawable(Color.parseColor("#38BDF8"))
            decisionTitleView.text = "MONITORANDO MOB LETS"
            decisionTitleView.setTextColor(Color.WHITE)
            rateMetricView.text = if (runtime.isAccessibilityConnected) {
                "Acessibilidade ON • Meta R$ 1,90/km"
            } else {
                "Ative Acessibilidade ou teste no Painel"
            }
            offerSummaryView.text = runtime.lastStatusMessage
            routeBreakdownView.text = "Rota padrão: Você → Loja → Cliente → Centro MOC"
            alertBannerView.visibility = View.GONE
            return
        }

        val (dotColor, titleLabel, borderHex) = when (offer.decision) {
            TrafficLightDecision.GREEN.name -> Triple(
                Color.parseColor("#10B981"),
                "VERDE • COMPENSA",
                "#10B981"
            )
            TrafficLightDecision.YELLOW.name -> Triple(
                Color.parseColor("#F59E0B"),
                "AMARELO • ATENÇÃO",
                "#F59E0B"
            )
            else -> Triple(
                Color.parseColor("#EF4444"),
                "VERMELHO • NÃO COMPENSA",
                "#EF4444"
            )
        }

        (overlayRoot?.background as? GradientDrawable)?.setStroke(dp(2), Color.parseColor(borderHex))
        decisionDotView.background = circleDrawable(dotColor)
        decisionTitleView.text = titleLabel
        decisionTitleView.setTextColor(dotColor)

        val ptBr = Locale("pt", "BR")
        val priceTxt = String.format(ptBr, "R$ %.2f", offer.offerPriceBrl)
        val rateTxt = String.format(ptBr, "R$ %.2f/km", offer.earningsPerKm)
        val totalKmTxt = String.format(ptBr, "%.1f km", offer.totalKm)
        val routeTypeTag = if (offer.routeSource == "OSRM_REAL_ROADS") "OSRM Real" else "Estimada"
        rateMetricView.text = "$priceTxt • $totalKmTxt ($routeTypeTag) • $rateTxt"

        offerSummaryView.text = "Loja: ${offer.pickupNeighborhood} → Cliente: ${offer.customerNeighborhood}"
        routeBreakdownView.text = String.format(
            ptBr,
            "1) %.1fkm Loja  2) %.1fkm Cliente  3) %.1fkm Centro",
            offer.leg1CurrentToPickupKm,
            offer.leg2PickupToCustomerKm,
            offer.leg3CustomerToCenterKm
        )

        val hasUnidentifiedNeighborhood =
            offer.pickupNeighborhood == "Bairro não identificado" ||
                offer.customerNeighborhood == "Bairro não identificado"

        if (!offer.neighborhoodAlert.isNullOrBlank()) {
            alertBannerView.visibility = View.VISIBLE
            (alertBannerView.background as? GradientDrawable)?.setColor(Color.parseColor("#7F1D1D"))
            alertBannerView.setTextColor(Color.parseColor("#FECACA"))
            alertBannerView.text = "⚠ ${offer.neighborhoodAlert}"
        } else if (hasUnidentifiedNeighborhood) {
            alertBannerView.visibility = View.VISIBLE
            (alertBannerView.background as? GradientDrawable)?.setColor(Color.parseColor("#78350F"))
            alertBannerView.setTextColor(Color.parseColor("#FDE68A"))
            alertBannerView.text = "⚠ Bairro não identificado — confira o endereço"
        } else {
            alertBannerView.visibility = View.GONE
        }
    }

    private fun circleDrawable(color: Int): GradientDrawable = GradientDrawable().apply {
        shape = GradientDrawable.OVAL
        setColor(color)
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                getString(R.string.overlay_notification_channel_name),
                NotificationManager.IMPORTANCE_LOW
            ).apply {
                description = getString(R.string.overlay_notification_channel_desc)
            }
            val nm = getSystemService(NotificationManager::class.java)
            nm.createNotificationChannel(channel)
        }
    }

    private fun buildNotification(): Notification {
        val openIntent = PendingIntent.getActivity(
            this,
            0,
            Intent(this, MainActivity::class.java),
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )
        val stopIntent = PendingIntent.getService(
            this,
            1,
            Intent(this, FloatingOverlayService::class.java).apply { action = ACTION_STOP },
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )

        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle(getString(R.string.overlay_notification_title))
            .setContentText(getString(R.string.overlay_notification_text))
            .setOngoing(true)
            .setContentIntent(openIntent)
            .addAction(0, "Parar Overlay", stopIntent)
            .build()
    }

    private fun dp(value: Int): Int =
        (value * resources.displayMetrics.density).toInt()

    override fun onDestroy() {
        super.onDestroy()
        serviceScope.cancel()
        overlayRoot?.let { view ->
            try {
                windowManager?.removeView(view)
            } catch (_: Exception) {
            }
        }
        overlayRoot = null
        ServiceRuntimeBus.setOverlayServiceRunning(false)
    }

    override fun onBind(intent: Intent?): IBinder? = null

    companion object {
        const val CHANNEL_ID = "rota_overlay_channel"
        const val NOTIFICATION_ID = 4102
        const val ACTION_SHOW_OR_UPDATE = "com.example.action.SHOW_OR_UPDATE_OVERLAY"
        const val ACTION_STOP = "com.example.action.STOP_OVERLAY"
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/RotaInteligenteApp.kt
package com.example

import android.app.Application
import com.example.data.GeoCacheStore
import com.example.data.OfferRepository
import com.example.data.RoomGeoCacheStore
import com.example.data.local.AppDatabase
import com.example.data.preferences.DriverPreferencesRepository
import com.example.domain.LocationHelper
import com.example.domain.OcrFallbackProcessor
import com.example.domain.OfferAnalysisCoordinator
import com.example.domain.RouteCalculator
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch

class AppContainer(application: Application) {
    private val database = AppDatabase.getInstance(application)
    val geoCacheStore: GeoCacheStore = RoomGeoCacheStore(database.geoCacheDao())
    val offerRepository = OfferRepository(
        offerDao = database.offerDao(),
        neighborhoodDao = database.neighborhoodDao()
    )
    val preferencesRepository = DriverPreferencesRepository(application)
    val locationHelper = LocationHelper(application)
    val routeCalculator = RouteCalculator(
        context = application,
        cacheStore = geoCacheStore
    )
    val ocrProcessor = OcrFallbackProcessor()
    val analysisCoordinator = OfferAnalysisCoordinator(
        context = application,
        offerRepository = offerRepository,
        preferencesRepository = preferencesRepository,
        locationHelper = locationHelper,
        routeCalculator = routeCalculator,
        ocrProcessor = ocrProcessor
    )
}

class RotaInteligenteApp : Application() {
    lateinit var container: AppContainer
        private set

    private val appScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)

    override fun onCreate() {
        super.onCreate()
        container = AppContainer(this)
        appScope.launch {
            container.offerRepository.ensureSeededNeighborhoods()
            container.offerRepository.pruneOldOffers()
            container.geoCacheStore.pruneExpired()
        }
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/MainActivity.kt
package com.example

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.safeDrawing
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.Dashboard
import androidx.compose.material.icons.outlined.History
import androidx.compose.material.icons.outlined.Map
import androidx.compose.material.icons.outlined.Settings
import androidx.compose.material.icons.rounded.Dashboard
import androidx.compose.material.icons.rounded.History
import androidx.compose.material.icons.rounded.Map
import androidx.compose.material.icons.rounded.Settings
import androidx.compose.material3.Icon
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.NavigationRail
import androidx.compose.material3.NavigationRailItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.unit.dp
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.compose.LifecycleEventEffect
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavDestination.Companion.hasRoute
import androidx.navigation.NavGraph.Companion.findStartDestination
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import com.example.ui.MainViewModel
import com.example.ui.screens.DashboardScreen
import com.example.ui.screens.HistoryScreen
import com.example.ui.screens.NeighborhoodsScreen
import com.example.ui.screens.SettingsScreen
import com.example.ui.theme.RotaInteligenteTheme
import kotlinx.serialization.Serializable

@Serializable
data object DashboardRoute

@Serializable
data object HistoryRoute

@Serializable
data object NeighborhoodsRoute

@Serializable
data object SettingsRoute

private data class TopLevelDestination<T : Any>(
    val route: T,
    val label: String,
    val selectedIcon: ImageVector,
    val unselectedIcon: ImageVector,
    val testTag: String
)

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            RotaInteligenteTheme(darkTheme = true) {
                RotaInteligenteRoot()
            }
        }
    }
}

@Composable
fun RotaInteligenteRoot(
    viewModel: MainViewModel = viewModel()
) {
    val uiState by viewModel.uiState.collectAsStateWithLifecycle()
    val navController = rememberNavController()
    val navBackStackEntry by navController.currentBackStackEntryAsState()
    val currentDestination = navBackStackEntry?.destination

    LifecycleEventEffect(Lifecycle.Event.ON_RESUME) {
        viewModel.refreshPermissions()
    }

    val destinations = listOf(
        TopLevelDestination(DashboardRoute, "Painel", Icons.Rounded.Dashboard, Icons.Outlined.Dashboard, "nav_dashboard"),
        TopLevelDestination(HistoryRoute, "Histórico", Icons.Rounded.History, Icons.Outlined.History, "nav_history"),
        TopLevelDestination(NeighborhoodsRoute, "Bairros", Icons.Rounded.Map, Icons.Outlined.Map, "nav_neighborhoods"),
        TopLevelDestination(SettingsRoute, "Ajustes", Icons.Rounded.Settings, Icons.Outlined.Settings, "nav_settings")
    )

    val navigateTo: (Any) -> Unit = { target ->
        navController.navigate(target) {
            popUpTo(navController.graph.findStartDestination().id) {
                saveState = true
            }
            launchSingleTop = true
            restoreState = true
        }
    }

    BoxWithConstraints(modifier = Modifier.fillMaxSize()) {
        val useNavigationRail = maxWidth >= 600.dp

        Scaffold(
            modifier = Modifier.fillMaxSize(),
            contentWindowInsets = WindowInsets.safeDrawing,
            bottomBar = {
                if (!useNavigationRail) {
                    NavigationBar {
                        destinations.forEach { dest ->
                            val selected = currentDestination?.hasRoute(dest.route::class) == true
                            NavigationBarItem(
                                selected = selected,
                                onClick = { navigateTo(dest.route) },
                                icon = {
                                    Icon(
                                        imageVector = if (selected) dest.selectedIcon else dest.unselectedIcon,
                                        contentDescription = dest.label
                                    )
                                },
                                label = { Text(dest.label) },
                                modifier = Modifier.testTag(dest.testTag)
                            )
                        }
                    }
                }
            }
        ) { innerPadding ->
            Row(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(innerPadding)
            ) {
                if (useNavigationRail) {
                    NavigationRail {
                        destinations.forEach { dest ->
                            val selected = currentDestination?.hasRoute(dest.route::class) == true
                            NavigationRailItem(
                                selected = selected,
                                onClick = { navigateTo(dest.route) },
                                icon = {
                                    Icon(
                                        imageVector = if (selected) dest.selectedIcon else dest.unselectedIcon,
                                        contentDescription = dest.label
                                    )
                                },
                                label = { Text(dest.label) },
                                modifier = Modifier.testTag(dest.testTag)
                            )
                        }
                    }
                }

                NavHost(
                    navController = navController,
                    startDestination = DashboardRoute,
                    modifier = Modifier.weight(1f)
                ) {
                    composable<DashboardRoute> {
                        DashboardScreen(
                            state = uiState,
                            onRefreshPermissions = viewModel::refreshPermissions,
                            onToggleOverlay = viewModel::toggleFloatingOverlay,
                            onAnalyzeManual = viewModel::analyzeManualOffer,
                            onAnalyzeOcrImage = viewModel::analyzeScreenshotUri,
                            onDismissFeedback = viewModel::clearFeedback
                        )
                    }
                    composable<HistoryRoute> {
                        HistoryScreen(
                            offers = uiState.offerHistory,
                            onDeleteOffer = viewModel::deleteOffer,
                            onClearAll = viewModel::clearHistory
                        )
                    }
                    composable<NeighborhoodsRoute> {
                        NeighborhoodsScreen(
                            rules = uiState.neighborhoodRules,
                            onUpdateStatus = viewModel::updateNeighborhoodStatus,
                            onAddNeighborhood = viewModel::addCustomNeighborhood,
                            onDeleteCustom = viewModel::deleteCustomNeighborhood
                        )
                    }
                    composable<SettingsRoute> {
                        SettingsScreen(
                            settings = uiState.settings,
                            onUpdateTargetPerKm = viewModel::updateMinTargetPerKm,
                            onToggleOcrFallback = viewModel::setOcrFallbackEnabled,
                            onToggleOsrmRouting = viewModel::setUseOsrmRoadRouting,
                            onToggleAutoShowOverlay = viewModel::setAutoShowOverlayOnOffer,
                            onToggleStrictMobLets = viewModel::setStrictMobLetsPackageFilter
                        )
                    }
                }
            }
        }
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/ui/MainViewModel.kt
package com.example.ui

import android.Manifest
import android.app.Application
import android.content.ComponentName
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.text.TextUtils
import androidx.core.content.ContextCompat
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import com.example.RotaInteligenteApp
import com.example.data.local.AnalyzedOfferEntity
import com.example.data.local.NeighborhoodRuleEntity
import com.example.data.local.NeighborhoodStatus
import com.example.data.local.OfferCaptureSource
import com.example.data.preferences.DriverSettings
import com.example.domain.OfferAnalysisCoordinator
import com.example.domain.OfferAnalysisOutcome
import com.example.service.MobLetsAccessibilityService
import com.example.service.ServiceRuntimeBus
import com.example.service.ServiceRuntimeState
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch

data class PermissionSnapshot(
    val accessibilityEnabled: Boolean = false,
    val overlayGranted: Boolean = false,
    val locationGranted: Boolean = false,
    val notificationsGranted: Boolean = true
) {
    val allCoreGranted: Boolean
        get() = accessibilityEnabled && overlayGranted && locationGranted && notificationsGranted
}

data class DashboardUiState(
    val runtime: ServiceRuntimeState = ServiceRuntimeState(),
    val permissions: PermissionSnapshot = PermissionSnapshot(),
    val latestOffer: AnalyzedOfferEntity? = null,
    val offerHistory: List<AnalyzedOfferEntity> = emptyList(),
    val neighborhoodRules: List<NeighborhoodRuleEntity> = emptyList(),
    val settings: DriverSettings = DriverSettings(),
    val isManualProcessing: Boolean = false,
    val feedbackBanner: String? = null
)

class MainViewModel(application: Application) : AndroidViewModel(application) {

    private val app = application as RotaInteligenteApp
    private val container = app.container

    private val permissionsFlow = MutableStateFlow(readPermissions())
    private val manualProcessingFlow = MutableStateFlow(false)
    private val feedbackFlow = MutableStateFlow<String?>(null)

    private val baseDataFlow = combine(
        ServiceRuntimeBus.state,
        permissionsFlow,
        container.offerRepository.latestOffer,
        container.offerRepository.allOffers,
        container.offerRepository.allNeighborhoodRules
    ) { runtime, permissions, latestOfferFromDb, history, rules ->
        val effectiveLatest = when {
            runtime.isAnalyzing -> null
            !runtime.lastAnalysisError.isNullOrBlank() -> null
            runtime.latestOffer != null -> runtime.latestOffer
            else -> latestOfferFromDb
        }
        Triple(
            Pair(runtime, permissions),
            Pair(effectiveLatest, history),
            rules
        )
    }

    val uiState: StateFlow<DashboardUiState> = combine(
        baseDataFlow,
        container.preferencesRepository.settingsFlow,
        manualProcessingFlow,
        feedbackFlow
    ) { base, settings, isManualProcessing, feedback ->
        DashboardUiState(
            runtime = base.first.first,
            permissions = base.first.second,
            latestOffer = base.second.first,
            offerHistory = base.second.second,
            neighborhoodRules = base.third,
            settings = settings,
            isManualProcessing = isManualProcessing,
            feedbackBanner = feedback
        )
    }.stateIn(
        scope = viewModelScope,
        started = SharingStarted.WhileSubscribed(5000),
        initialValue = DashboardUiState(permissions = readPermissions())
    )

    fun refreshPermissions() {
        val snap = readPermissions()
        permissionsFlow.value = snap
        if (snap.accessibilityEnabled != ServiceRuntimeBus.state.value.isAccessibilityConnected) {
            ServiceRuntimeBus.setAccessibilityConnected(snap.accessibilityEnabled)
        }
    }

    fun clearFeedback() {
        feedbackFlow.value = null
    }

    fun analyzeManualOffer(
        priceInput: String,
        pickupAddress: String,
        customerAddress: String
    ) {
        val sanitizedPrice = priceInput
            .replace("R$", "", ignoreCase = true)
            .replace(" ", "")
            .replace(",", ".")
            .toDoubleOrNull()

        if (sanitizedPrice == null || sanitizedPrice <= 0.0) {
            feedbackFlow.value = "Informe um valor válido em reais (ex: 15,50)."
            return
        }
        if (pickupAddress.isBlank() || customerAddress.isBlank()) {
            feedbackFlow.value = "Preencha o endereço da loja de retirada e do cliente."
            return
        }

        viewModelScope.launch {
            manualProcessingFlow.value = true
            try {
                when (
                    val outcome = container.analysisCoordinator.analyzeStructuredOffer(
                        priceBrl = sanitizedPrice,
                        pickupAddress = pickupAddress.trim(),
                        customerAddress = customerAddress.trim(),
                        source = OfferCaptureSource.MANUAL,
                        rawSnippet = "Entrada manual • Valor: R$ $priceInput | Retirada: $pickupAddress | Entrega: $customerAddress"
                    )
                ) {
                    is OfferAnalysisOutcome.Success -> feedbackFlow.value = outcome.offer.decisionReason
                    is OfferAnalysisOutcome.Unresolved -> feedbackFlow.value = outcome.reason
                    is OfferAnalysisOutcome.Error -> feedbackFlow.value = outcome.reason
                }
            } catch (e: CancellationException) {
                throw e
            } catch (e: Exception) {
                feedbackFlow.value = "Erro ao calcular rota: ${e.message ?: "verifique os endereços"}"
            } finally {
                manualProcessingFlow.value = false
            }
        }
    }

    fun analyzeScreenshotUri(uri: Uri) {
        viewModelScope.launch {
            manualProcessingFlow.value = true
            try {
                when (val outcome = container.analysisCoordinator.analyzeFromOcrImageUri(uri)) {
                    is OfferAnalysisOutcome.Success -> feedbackFlow.value = "OCR concluído: ${outcome.offer.decisionReason}"
                    is OfferAnalysisOutcome.Unresolved -> feedbackFlow.value = outcome.reason
                    is OfferAnalysisOutcome.Error -> feedbackFlow.value = outcome.reason
                }
            } catch (e: CancellationException) {
                throw e
            } finally {
                manualProcessingFlow.value = false
            }
        }
    }

    fun toggleFloatingOverlay() {
        val permissions = readPermissions()
        permissionsFlow.value = permissions
        if (!permissions.overlayGranted) {
            feedbackFlow.value = "Conceda a permissão 'Sobrepor a outros apps' antes de iniciar o painel flutuante."
            return
        }
        if (ServiceRuntimeBus.state.value.isOverlayServiceRunning) {
            OfferAnalysisCoordinator.stopOverlay(app)
            feedbackFlow.value = "Janela flutuante encerrada."
        } else {
            OfferAnalysisCoordinator.startOrUpdateOverlay(app)
            feedbackFlow.value = "Janela flutuante iniciada sobre outros aplicativos."
        }
    }

    fun deleteOffer(id: Long) {
        viewModelScope.launch {
            if (ServiceRuntimeBus.state.value.latestOffer?.id == id) {
                ServiceRuntimeBus.clearLatestOffer()
            }
            container.offerRepository.deleteOffer(id)
        }
    }

    fun clearHistory() {
        viewModelScope.launch {
            ServiceRuntimeBus.clearLatestOffer()
            container.offerRepository.clearHistory()
            feedbackFlow.value = "Histórico de ofertas limpo."
        }
    }

    fun updateNeighborhoodStatus(name: String, status: NeighborhoodStatus, notes: String = "") {
        viewModelScope.launch {
            container.offerRepository.updateNeighborhoodStatus(name, status, notes)
        }
    }

    fun addCustomNeighborhood(name: String, status: NeighborhoodStatus, notes: String) {
        viewModelScope.launch {
            container.offerRepository.addCustomNeighborhood(name, status, notes)
            feedbackFlow.value = "Bairro '$name' salvo nas regras."
        }
    }

    fun deleteCustomNeighborhood(name: String) {
        viewModelScope.launch {
            container.offerRepository.deleteCustomNeighborhood(name)
        }
    }

    fun updateMinTargetPerKm(value: Double) {
        viewModelScope.launch {
            container.preferencesRepository.setMinTargetPerKm(value)
        }
    }

    fun setOcrFallbackEnabled(enabled: Boolean) {
        viewModelScope.launch {
            container.preferencesRepository.setOcrFallbackEnabled(enabled)
        }
    }

    fun setUseOsrmRoadRouting(enabled: Boolean) {
        viewModelScope.launch {
            container.preferencesRepository.setUseOsrmRoadRouting(enabled)
        }
    }

    fun setAutoShowOverlayOnOffer(enabled: Boolean) {
        viewModelScope.launch {
            container.preferencesRepository.setAutoShowOverlayOnOffer(enabled)
        }
    }

    fun setStrictMobLetsPackageFilter(enabled: Boolean) {
        viewModelScope.launch {
            container.preferencesRepository.setStrictMobLetsPackageFilter(enabled)
        }
    }

    private fun readPermissions(): PermissionSnapshot {
        val overlayGranted = Settings.canDrawOverlays(app)
        val locationGranted = ContextCompat.checkSelfPermission(
            app,
            Manifest.permission.ACCESS_FINE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED || ContextCompat.checkSelfPermission(
            app,
            Manifest.permission.ACCESS_COARSE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED

        val notificationsGranted = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            ContextCompat.checkSelfPermission(
                app,
                Manifest.permission.POST_NOTIFICATIONS
            ) == PackageManager.PERMISSION_GRANTED
        } else {
            true
        }

        return PermissionSnapshot(
            accessibilityEnabled = isAccessibilityServiceEnabled(),
            overlayGranted = overlayGranted,
            locationGranted = locationGranted,
            notificationsGranted = notificationsGranted
        )
    }

    private fun isAccessibilityServiceEnabled(): Boolean {
        val expectedComponent = ComponentName(app, MobLetsAccessibilityService::class.java)
        val enabledServices = Settings.Secure.getString(
            app.contentResolver,
            Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES
        ) ?: return false

        val splitter = TextUtils.SimpleStringSplitter(':')
        splitter.setString(enabledServices)
        while (splitter.hasNext()) {
            val componentString = splitter.next()
            val component = ComponentName.unflattenFromString(componentString)
            if (component == expectedComponent) return true
        }
        return false
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/ui/theme/Color.kt
package com.example.ui.theme

import androidx.compose.ui.graphics.Color

val ObsidianBg = Color(0xFF070B14)
val SlateSurface = Color(0xFF0F172A)
val SlateSurfaceElevated = Color(0xFF162036)
val SlateSurfaceHighest = Color(0xFF1E293B)
val SlateOutline = Color(0xFF334155)
val SlateOutlineSoft = Color(0xFF1F2D44)

val TextPrimaryDark = Color(0xFFF8FAFC)
val TextSecondaryDark = Color(0xFF94A3B8)

val CloudBg = Color(0xFFF4F7FB)
val PaperSurface = Color(0xFFFFFFFF)
val PaperSurfaceVariant = Color(0xFFE7EEF8)
val InkPrimary = Color(0xFF0F172A)
val InkSecondary = Color(0xFF475569)
val LightOutline = Color(0xFFCBD5E1)

val TrafficGreen = Color(0xFF10B981)
val TrafficGreenContainer = Color(0xFF064E3B)
val TrafficGreenBright = Color(0xFF34D399)

val TrafficYellow = Color(0xFFF59E0B)
val TrafficYellowContainer = Color(0xFF451A03)
val TrafficYellowBright = Color(0xFFFBBF24)

val TrafficRed = Color(0xFFEF4444)
val TrafficRedContainer = Color(0xFF450A0A)
val TrafficRedBright = Color(0xFFF87171)

val RouteCyan = Color(0xFF38BDF8)
val RouteCyanDark = Color(0xFF0284C7)
val BrandIndigo = Color(0xFF6366F1)
EOF

cat << 'EOF' > app/src/main/java/com/example/ui/theme/Type.kt
package com.example.ui.theme

import androidx.compose.material3.Typography
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.sp

val SpaceGroteskFontFamily = FontFamily.SansSerif
val PlusJakartaSansFontFamily = FontFamily.SansSerif

val RotaTypography = Typography(
    displayLarge = TextStyle(
        fontFamily = SpaceGroteskFontFamily,
        fontWeight = FontWeight.Bold,
        fontSize = 36.sp,
        lineHeight = 42.sp,
        letterSpacing = (-0.5).sp
    ),
    displayMedium = TextStyle(
        fontFamily = SpaceGroteskFontFamily,
        fontWeight = FontWeight.Bold,
        fontSize = 28.sp,
        lineHeight = 34.sp,
        letterSpacing = (-0.25).sp
    ),
    headlineMedium = TextStyle(
        fontFamily = SpaceGroteskFontFamily,
        fontWeight = FontWeight.Bold,
        fontSize = 22.sp,
        lineHeight = 28.sp
    ),
    titleLarge = TextStyle(
        fontFamily = SpaceGroteskFontFamily,
        fontWeight = FontWeight.SemiBold,
        fontSize = 18.sp,
        lineHeight = 24.sp
    ),
    titleMedium = TextStyle(
        fontFamily = PlusJakartaSansFontFamily,
        fontWeight = FontWeight.SemiBold,
        fontSize = 16.sp,
        lineHeight = 22.sp
    ),
    bodyLarge = TextStyle(
        fontFamily = PlusJakartaSansFontFamily,
        fontWeight = FontWeight.Normal,
        fontSize = 15.sp,
        lineHeight = 22.sp
    ),
    bodyMedium = TextStyle(
        fontFamily = PlusJakartaSansFontFamily,
        fontWeight = FontWeight.Normal,
        fontSize = 13.sp,
        lineHeight = 19.sp
    ),
    labelLarge = TextStyle(
        fontFamily = SpaceGroteskFontFamily,
        fontWeight = FontWeight.SemiBold,
        fontSize = 13.sp,
        lineHeight = 18.sp,
        letterSpacing = 0.2.sp
    ),
    labelMedium = TextStyle(
        fontFamily = PlusJakartaSansFontFamily,
        fontWeight = FontWeight.SemiBold,
        fontSize = 11.sp,
        lineHeight = 16.sp,
        letterSpacing = 0.4.sp
    ),
    labelSmall = TextStyle(
        fontFamily = PlusJakartaSansFontFamily,
        fontWeight = FontWeight.Medium,
        fontSize = 10.sp,
        lineHeight = 14.sp,
        letterSpacing = 0.4.sp
    )
)
EOF

cat << 'EOF' > app/src/main/java/com/example/ui/theme/Theme.kt
package com.example.ui.theme

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Shapes
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.Immutable
import androidx.compose.runtime.staticCompositionLocalOf
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp

@Immutable
data class RotaSemanticColors(
    val green: Color,
    val greenContainer: Color,
    val onGreenContainer: Color,
    val yellow: Color,
    val yellowContainer: Color,
    val onYellowContainer: Color,
    val red: Color,
    val redContainer: Color,
    val onRedContainer: Color,
    val routeCyan: Color
)

private val DarkSemanticColors = RotaSemanticColors(
    green = TrafficGreenBright,
    greenContainer = TrafficGreenContainer,
    onGreenContainer = Color(0xFFA7F3D0),
    yellow = TrafficYellowBright,
    yellowContainer = TrafficYellowContainer,
    onYellowContainer = Color(0xFFFDE68A),
    red = TrafficRedBright,
    redContainer = TrafficRedContainer,
    onRedContainer = Color(0xFFFECACA),
    routeCyan = RouteCyan
)

private val LightSemanticColors = RotaSemanticColors(
    green = Color(0xFF059669),
    greenContainer = Color(0xFFD1FAE5),
    onGreenContainer = Color(0xFF064E3B),
    yellow = Color(0xFFD97706),
    yellowContainer = Color(0xFFFEF3C7),
    onYellowContainer = Color(0xFF78350F),
    red = Color(0xFFDC2626),
    redContainer = Color(0xFFFEE2E2),
    onRedContainer = Color(0xFF7F1D1D),
    routeCyan = RouteCyanDark
)

val LocalRotaColors = staticCompositionLocalOf { DarkSemanticColors }

private val DarkColorScheme = darkColorScheme(
    primary = TrafficGreenBright,
    onPrimary = Color(0xFF022C22),
    primaryContainer = TrafficGreenContainer,
    onPrimaryContainer = Color(0xFFA7F3D0),
    secondary = RouteCyan,
    onSecondary = Color(0xFF082F49),
    secondaryContainer = Color(0xFF0C4A6E),
    onSecondaryContainer = Color(0xFFBAE6FD),
    tertiary = TrafficYellowBright,
    onTertiary = Color(0xFF451A03),
    background = ObsidianBg,
    onBackground = TextPrimaryDark,
    surface = SlateSurface,
    onSurface = TextPrimaryDark,
    surfaceVariant = SlateSurfaceElevated,
    onSurfaceVariant = TextSecondaryDark,
    surfaceContainerLow = SlateSurface,
    surfaceContainer = SlateSurfaceElevated,
    surfaceContainerHigh = SlateSurfaceHighest,
    outline = SlateOutline,
    outlineVariant = SlateOutlineSoft,
    error = TrafficRedBright,
    onError = Color(0xFF450A0A),
    errorContainer = TrafficRedContainer,
    onErrorContainer = Color(0xFFFECACA)
)

private val LightColorScheme = lightColorScheme(
    primary = Color(0xFF059669),
    onPrimary = Color.White,
    primaryContainer = Color(0xFFD1FAE5),
    onPrimaryContainer = Color(0xFF064E3B),
    secondary = RouteCyanDark,
    onSecondary = Color.White,
    secondaryContainer = Color(0xFFE0F2FE),
    onSecondaryContainer = Color(0xFF0C4A6E),
    tertiary = Color(0xFFD97706),
    onTertiary = Color.White,
    background = CloudBg,
    onBackground = InkPrimary,
    surface = PaperSurface,
    onSurface = InkPrimary,
    surfaceVariant = PaperSurfaceVariant,
    onSurfaceVariant = InkSecondary,
    surfaceContainerLow = PaperSurface,
    surfaceContainer = Color(0xFFF8FAFC),
    surfaceContainerHigh = PaperSurfaceVariant,
    outline = LightOutline,
    outlineVariant = Color(0xFFE2E8F0),
    error = Color(0xFFDC2626),
    onError = Color.White,
    errorContainer = Color(0xFFFEE2E2),
    onErrorContainer = Color(0xFF7F1D1D)
)

val RotaShapes = Shapes(
    small = RoundedCornerShape(10.dp),
    medium = RoundedCornerShape(16.dp),
    large = RoundedCornerShape(22.dp),
    extraLarge = RoundedCornerShape(28.dp)
)

@Composable
fun RotaInteligenteTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    content: @Composable () -> Unit
) {
    val colorScheme = if (darkTheme) DarkColorScheme else LightColorScheme
    val semanticColors = if (darkTheme) DarkSemanticColors else LightSemanticColors

    CompositionLocalProvider(LocalRotaColors provides semanticColors) {
        MaterialTheme(
            colorScheme = colorScheme,
            typography = RotaTypography,
            shapes = RotaShapes,
            content = content
        )
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/ui/components/HudComponents.kt
package com.example.ui.components

import androidx.compose.animation.animateColorAsState
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.CheckCircle
import androidx.compose.material.icons.rounded.Dangerous
import androidx.compose.material.icons.rounded.DirectionsBike
import androidx.compose.material.icons.rounded.LocationOn
import androidx.compose.material.icons.rounded.Storefront
import androidx.compose.material.icons.rounded.Warning
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.PathEffect
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.example.data.local.AnalyzedOfferEntity
import com.example.data.local.TrafficLightDecision
import com.example.ui.theme.LocalRotaColors
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

@Composable
fun StatusPillBadge(
    label: String,
    active: Boolean,
    modifier: Modifier = Modifier
) {
    val rotaColors = LocalRotaColors.current
    val dotColor by animateColorAsState(
        targetValue = if (active) rotaColors.green else MaterialTheme.colorScheme.outline,
        label = "statusDot"
    )
    val bgColor = if (active) {
        rotaColors.greenContainer.copy(alpha = 0.55f)
    } else {
        MaterialTheme.colorScheme.surfaceContainerHigh
    }

    Surface(
        modifier = modifier,
        shape = RoundedCornerShape(50),
        color = bgColor,
        border = BorderStroke(
            width = 1.dp,
            color = if (active) rotaColors.green.copy(alpha = 0.45f) else MaterialTheme.colorScheme.outlineVariant
        )
    ) {
        Row(
            modifier = Modifier.padding(horizontal = 10.dp, vertical = 6.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Box(
                modifier = Modifier
                    .size(8.dp)
                    .clip(CircleShape)
                    .background(dotColor)
            )
            Spacer(modifier = Modifier.width(6.dp))
            Text(
                text = label,
                style = MaterialTheme.typography.labelMedium,
                color = if (active) rotaColors.onGreenContainer else MaterialTheme.colorScheme.onSurfaceVariant,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis
            )
        }
    }
}

@Composable
fun TrafficLightDecisionCard(
    offer: AnalyzedOfferEntity,
    modifier: Modifier = Modifier
) {
    val rotaColors = LocalRotaColors.current
    val ptBr = Locale("pt", "BR")

    val (accentColor, containerColor, onContainerColor, badgeLabel, icon) = when (offer.decision) {
        TrafficLightDecision.GREEN.name -> DecisionVisuals(
            accent = rotaColors.green,
            container = rotaColors.greenContainer,
            onContainer = rotaColors.onGreenContainer,
            label = "VERDE • COMPENSA (WORTH IT)",
            icon = Icons.Rounded.CheckCircle
        )
        TrafficLightDecision.YELLOW.name -> DecisionVisuals(
            accent = rotaColors.yellow,
            container = rotaColors.yellowContainer,
            onContainer = rotaColors.onYellowContainer,
            label = "AMARELO • ATENÇÃO (CAUTION)",
            icon = Icons.Rounded.Warning
        )
        else -> DecisionVisuals(
            accent = rotaColors.red,
            container = rotaColors.redContainer,
            onContainer = rotaColors.onRedContainer,
            label = "VERMELHO • NÃO COMPENSA",
            icon = Icons.Rounded.Dangerous
        )
    }

    Card(
        modifier = modifier.fillMaxWidth(),
        shape = MaterialTheme.shapes.large,
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surfaceContainer
        ),
        border = BorderStroke(1.5.dp, accentColor.copy(alpha = 0.7f))
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Surface(
                    shape = RoundedCornerShape(50),
                    color = containerColor
                ) {
                    Row(
                        modifier = Modifier.padding(horizontal = 12.dp, vertical = 6.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Icon(
                            imageVector = icon,
                            contentDescription = badgeLabel,
                            tint = accentColor,
                            modifier = Modifier.size(18.dp)
                        )
                        Spacer(modifier = Modifier.width(6.dp))
                        Text(
                            text = badgeLabel,
                            style = MaterialTheme.typography.labelLarge,
                            color = onContainerColor
                        )
                    }
                }

                // Traffic light 3-dot visual indicator
                Row(
                    horizontalArrangement = Arrangement.spacedBy(5.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    TrafficDot(
                        color = rotaColors.red,
                        active = offer.decision == TrafficLightDecision.RED.name
                    )
                    TrafficDot(
                        color = rotaColors.yellow,
                        active = offer.decision == TrafficLightDecision.YELLOW.name
                    )
                    TrafficDot(
                        color = rotaColors.green,
                        active = offer.decision == TrafficLightDecision.GREEN.name
                    )
                }
            }

            Spacer(modifier = Modifier.height(14.dp))

            // Price, Total KM, and R$/km KPI strip
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.Bottom
            ) {
                Column {
                    Text(
                        text = "VALOR DA OFERTA",
                        style = MaterialTheme.typography.labelSmall,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                    Text(
                        text = String.format(ptBr, "R$ %.2f", offer.offerPriceBrl),
                        style = MaterialTheme.typography.displayMedium,
                        color = MaterialTheme.colorScheme.onSurface
                    )
                }

                Column(horizontalAlignment = Alignment.End) {
                    Text(
                        text = "GANHO REAL / KM",
                        style = MaterialTheme.typography.labelSmall,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                    Text(
                        text = String.format(ptBr, "R$ %.2f/km", offer.earningsPerKm),
                        style = MaterialTheme.typography.headlineMedium,
                        color = accentColor,
                        fontWeight = FontWeight.Bold
                    )
                    Text(
                        text = String.format(
                            ptBr,
                            "Total %.1f km • Meta R$ %.2f/km",
                            offer.totalKm,
                            offer.targetPerKm
                        ),
                        style = MaterialTheme.typography.labelMedium,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            }

            Spacer(modifier = Modifier.height(12.dp))

            // Explanation / Reason
            Text(
                text = offer.decisionReason,
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurface
            )

            if (!offer.neighborhoodAlert.isNullOrBlank()) {
                Spacer(modifier = Modifier.height(10.dp))
                Surface(
                    shape = MaterialTheme.shapes.small,
                    color = rotaColors.redContainer
                ) {
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(horizontal = 12.dp, vertical = 8.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Icon(
                            imageVector = Icons.Rounded.Warning,
                            contentDescription = "Alerta de bairro",
                            tint = rotaColors.red,
                            modifier = Modifier.size(18.dp)
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text(
                            text = offer.neighborhoodAlert,
                            style = MaterialTheme.typography.bodyMedium,
                            color = rotaColors.onRedContainer,
                            fontWeight = FontWeight.SemiBold
                        )
                    }
                }
            }

            val hasUnidentifiedNeighborhood =
                com.example.domain.MontesClarosGeoCatalog.isUnidentified(offer.pickupNeighborhood) ||
                    com.example.domain.MontesClarosGeoCatalog.isUnidentified(offer.customerNeighborhood)
            if (hasUnidentifiedNeighborhood) {
                Spacer(modifier = Modifier.height(10.dp))
                Surface(
                    modifier = Modifier.fillMaxWidth(),
                    shape = MaterialTheme.shapes.small,
                    color = rotaColors.yellowContainer
                ) {
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(horizontal = 12.dp, vertical = 8.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Icon(
                            imageVector = Icons.Rounded.Warning,
                            contentDescription = "Bairro não identificado",
                            tint = rotaColors.yellow,
                            modifier = Modifier.size(18.dp)
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text(
                            text = "Bairro não identificado com segurança — confira o endereço completo antes de aceitar.",
                            style = MaterialTheme.typography.bodyMedium,
                            color = rotaColors.onYellowContainer,
                            fontWeight = FontWeight.SemiBold
                        )
                    }
                }
            }

            Spacer(modifier = Modifier.height(14.dp))

            RouteFourLegDiagram(offer = offer)

            Spacer(modifier = Modifier.height(10.dp))

            // Metadata footer
            val timeFormat = SimpleDateFormat("HH:mm", Locale("pt", "BR"))
            val sourceLabel = when (offer.source) {
                "ACCESSIBILITY" -> "Acessibilidade"
                "OCR_SCREENSHOT" -> "OCR Automático"
                "OCR_IMAGE" -> "OCR Imagem"
                else -> "Análise Manual"
            }
            val routeLabel = if (offer.routeSource == "OSRM_REAL_ROADS") {
                "Rota Real (OSRM)"
            } else {
                "Distância Estimada (Offline)"
            }
            val gpsLabel = if (offer.usedGpsStart) "GPS em tempo real" else "Início: Centro MOC"

            Text(
                text = "$sourceLabel • $routeLabel • $gpsLabel • ${timeFormat.format(Date(offer.timestamp))}",
                style = MaterialTheme.typography.labelSmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
    }
}

@Composable
private fun TrafficDot(color: Color, active: Boolean) {
    Box(
        modifier = Modifier
            .size(if (active) 12.dp else 8.dp)
            .clip(CircleShape)
            .background(if (active) color else color.copy(alpha = 0.22f))
    )
}

@Composable
fun RouteFourLegDiagram(
    offer: AnalyzedOfferEntity,
    modifier: Modifier = Modifier
) {
    val rotaColors = LocalRotaColors.current
    val ptBr = Locale("pt", "BR")
    val lineColor = rotaColors.routeCyan
    val surfaceLineTrack = MaterialTheme.colorScheme.outlineVariant

    Surface(
        modifier = modifier.fillMaxWidth(),
        shape = MaterialTheme.shapes.medium,
        color = MaterialTheme.colorScheme.surfaceContainerHigh.copy(alpha = 0.6f)
    ) {
        Column(modifier = Modifier.padding(12.dp)) {
            Text(
                text = "ROTA COMPLETA (4 PONTOS)",
                style = MaterialTheme.typography.labelSmall,
                color = lineColor
            )
            Spacer(modifier = Modifier.height(10.dp))

            Canvas(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(22.dp)
                    .padding(horizontal = 12.dp)
            ) {
                val y = size.height / 2f
                val step = size.width / 3f
                val points = listOf(0f, step, step * 2f, size.width)

                drawLine(
                    color = surfaceLineTrack,
                    start = Offset(points.first(), y),
                    end = Offset(points.last(), y),
                    strokeWidth = 4.dp.toPx(),
                    cap = StrokeCap.Round
                )

                drawLine(
                    color = lineColor,
                    start = Offset(points[0], y),
                    end = Offset(points[2], y),
                    strokeWidth = 4.dp.toPx(),
                    cap = StrokeCap.Round
                )

                drawLine(
                    color = rotaColors.yellow,
                    start = Offset(points[2], y),
                    end = Offset(points[3], y),
                    strokeWidth = 3.5.dp.toPx(),
                    cap = StrokeCap.Round,
                    pathEffect = PathEffect.dashPathEffect(floatArrayOf(12f, 10f))
                )

                points.forEachIndexed { index, x ->
                    val nodeColor = when (index) {
                        0 -> lineColor
                        1 -> rotaColors.green
                        2 -> rotaColors.yellow
                        else -> lineColor
                    }
                    drawCircle(
                        color = nodeColor,
                        radius = 6.dp.toPx(),
                        center = Offset(x, y)
                    )
                }
            }

            Spacer(modifier = Modifier.height(8.dp))

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                LegLabel(
                    title = "1. Atual → Loja",
                    km = String.format(ptBr, "%.1f km", offer.leg1CurrentToPickupKm),
                    subtitle = offer.pickupNeighborhood,
                    icon = Icons.Rounded.DirectionsBike,
                    modifier = Modifier.weight(1f)
                )
                LegLabel(
                    title = "2. Loja → Cliente",
                    km = String.format(ptBr, "%.1f km", offer.leg2PickupToCustomerKm),
                    subtitle = offer.customerNeighborhood,
                    icon = Icons.Rounded.Storefront,
                    modifier = Modifier.weight(1f)
                )
                LegLabel(
                    title = "3. Retorno Centro",
                    km = String.format(ptBr, "%.1f km", offer.leg3CustomerToCenterKm),
                    subtitle = "Praça Dr. Carlos",
                    icon = Icons.Rounded.LocationOn,
                    modifier = Modifier.weight(1f)
                )
            }

            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = "Retirada: ${offer.pickupAddress}",
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis
            )
            Text(
                text = "Cliente: ${offer.customerAddress}",
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis
            )
        }
    }
}

@Composable
private fun LegLabel(
    title: String,
    km: String,
    subtitle: String,
    icon: androidx.compose.ui.graphics.vector.ImageVector,
    modifier: Modifier = Modifier
) {
    Column(modifier = modifier.padding(end = 4.dp)) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Icon(
                imageVector = icon,
                contentDescription = title,
                tint = MaterialTheme.colorScheme.secondary,
                modifier = Modifier.size(13.dp)
            )
            Spacer(modifier = Modifier.width(3.dp))
            Text(
                text = title,
                style = MaterialTheme.typography.labelSmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis
            )
        }
        Text(
            text = km,
            style = MaterialTheme.typography.labelLarge,
            color = MaterialTheme.colorScheme.onSurface
        )
        val isUnidentified = com.example.domain.MontesClarosGeoCatalog.isUnidentified(subtitle)
        val rotaColors = LocalRotaColors.current
        Text(
            text = subtitle,
            style = MaterialTheme.typography.labelSmall,
            color = if (isUnidentified) rotaColors.yellow else MaterialTheme.colorScheme.onSurfaceVariant,
            fontWeight = if (isUnidentified) FontWeight.SemiBold else FontWeight.Medium,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis
        )
    }
}

private data class DecisionVisuals(
    val accent: Color,
    val container: Color,
    val onContainer: Color,
    val label: String,
    val icon: androidx.compose.ui.graphics.vector.ImageVector
)
EOF

cat << 'EOF' > app/src/main/java/com/example/ui/screens/DashboardScreen.kt
package com.example.ui.screens

import android.Manifest
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.PickVisualMediaRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.AccessibilityNew
import androidx.compose.material.icons.rounded.Analytics
import androidx.compose.material.icons.rounded.CheckCircle
import androidx.compose.material.icons.rounded.Close
import androidx.compose.material.icons.rounded.DocumentScanner
import androidx.compose.material.icons.rounded.Layers
import androidx.compose.material.icons.rounded.LocationOn
import androidx.compose.material.icons.rounded.NotificationsActive
import androidx.compose.material.icons.rounded.PlayArrow
import androidx.compose.material.icons.rounded.Route
import androidx.compose.material.icons.rounded.Security
import androidx.compose.material.icons.rounded.Stop
import androidx.compose.material3.AssistChip
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.FilledTonalButton
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import com.example.R
import com.example.ui.DashboardUiState
import com.example.ui.components.StatusPillBadge
import com.example.ui.components.TrafficLightDecisionCard
import com.example.ui.theme.LocalRotaColors
import java.util.Locale

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun DashboardScreen(
    state: DashboardUiState,
    onRefreshPermissions: () -> Unit,
    onToggleOverlay: () -> Unit,
    onAnalyzeManual: (price: String, pickup: String, customer: String) -> Unit,
    onAnalyzeOcrImage: (Uri) -> Unit,
    onDismissFeedback: () -> Unit,
    modifier: Modifier = Modifier
) {
    val context = LocalContext.current
    val rotaColors = LocalRotaColors.current
    val ptBr = Locale("pt", "BR")

    var priceInput by rememberSaveable { mutableStateOf("18,50") }
    var pickupInput by rememberSaveable {
        mutableStateOf("Av. Deputado Esteves Rodrigues, 450 - Centro, Montes Claros")
    }
    var customerInput by rememberSaveable {
        mutableStateOf("Av. José Corrêa Machado, 920 - Ibituruna, Montes Claros")
    }

    val locationLauncher = rememberLauncherForActivityResult(
        contract = ActivityResultContracts.RequestMultiplePermissions()
    ) {
        onRefreshPermissions()
    }

    val notificationLauncher = rememberLauncherForActivityResult(
        contract = ActivityResultContracts.RequestPermission()
    ) {
        onRefreshPermissions()
    }

    val photoPickerLauncher = rememberLauncherForActivityResult(
        contract = ActivityResultContracts.PickVisualMedia()
    ) { uri ->
        if (uri != null) {
            onAnalyzeOcrImage(uri)
        }
    }

    Box(
        modifier = modifier.fillMaxSize(),
        contentAlignment = Alignment.TopCenter
    ) {
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .widthIn(max = 680.dp),
            contentPadding = PaddingValues(horizontal = 16.dp, vertical = 14.dp),
            verticalArrangement = Arrangement.spacedBy(14.dp)
        ) {
            // Hero HUD Banner
            item {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    shape = MaterialTheme.shapes.large,
                    border = BorderStroke(1.dp, MaterialTheme.colorScheme.outlineVariant)
                ) {
                    Box(modifier = Modifier.fillMaxWidth()) {
                        Image(
                            painter = painterResource(id = R.drawable.img_route_banner),
                            contentDescription = "Mapa estratégico de entregas em Montes Claros",
                            modifier = Modifier
                                .fillMaxWidth()
                                .height(188.dp),
                            contentScale = ContentScale.Crop
                        )
                        Box(
                            modifier = Modifier
                                .matchParentSize()
                                .background(
                                    Brush.verticalGradient(
                                        colors = listOf(
                                            Color(0xCC070B14),
                                            Color(0xEE090E1A)
                                        )
                                    )
                                )
                        )
                        Column(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(16.dp)
                        ) {
                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalArrangement = Arrangement.SpaceBetween,
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Column(modifier = Modifier.weight(1f)) {
                                    Text(
                                        text = "ROTA INTELIGENTE IA",
                                        style = MaterialTheme.typography.labelLarge,
                                        color = rotaColors.routeCyan
                                    )
                                    Text(
                                        text = "Mob Lets • Montes Claros",
                                        style = MaterialTheme.typography.headlineMedium,
                                        color = Color.White
                                    )
                                }
                                Surface(
                                    shape = MaterialTheme.shapes.small,
                                    color = rotaColors.greenContainer
                                ) {
                                    Text(
                                        text = String.format(ptBr, "Meta R$ %.2f/km", state.settings.minTargetPerKm),
                                        style = MaterialTheme.typography.labelLarge,
                                        color = rotaColors.onGreenContainer,
                                        modifier = Modifier.padding(horizontal = 10.dp, vertical = 6.dp)
                                    )
                                }
                            }

                            Spacer(modifier = Modifier.height(10.dp))

                            FlowRow(
                                horizontalArrangement = Arrangement.spacedBy(8.dp),
                                verticalArrangement = Arrangement.spacedBy(8.dp)
                            ) {
                                StatusPillBadge(
                                    label = if (state.permissions.accessibilityEnabled) "Acessibilidade ON" else "Acessibilidade OFF",
                                    active = state.permissions.accessibilityEnabled
                                )
                                StatusPillBadge(
                                    label = if (state.runtime.isOverlayServiceRunning) "Flutuante Ativa" else "Flutuante Parada",
                                    active = state.runtime.isOverlayServiceRunning
                                )
                                StatusPillBadge(
                                    label = if (state.permissions.locationGranted) "GPS Pronto" else "GPS Padrão MOC",
                                    active = state.permissions.locationGranted
                                )
                                StatusPillBadge(
                                    label = if (state.settings.ocrFallbackEnabled) "OCR ML Kit ON" else "OCR OFF",
                                    active = state.settings.ocrFallbackEnabled
                                )
                            }

                            Spacer(modifier = Modifier.height(10.dp))
                            Text(
                                text = state.runtime.lastStatusMessage,
                                style = MaterialTheme.typography.bodyMedium,
                                color = Color(0xFFCBD5E1)
                            )
                        }
                    }
                }
            }

            // Transient feedback banner
            item {
                AnimatedVisibility(visible = !state.feedbackBanner.isNullOrBlank()) {
                    Surface(
                        shape = MaterialTheme.shapes.medium,
                        color = MaterialTheme.colorScheme.secondaryContainer,
                        border = BorderStroke(1.dp, MaterialTheme.colorScheme.secondary.copy(alpha = 0.5f))
                    ) {
                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(horizontal = 12.dp, vertical = 10.dp),
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Text(
                                text = state.feedbackBanner.orEmpty(),
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSecondaryContainer,
                                modifier = Modifier.weight(1f)
                            )
                            IconButton(
                                onClick = onDismissFeedback,
                                modifier = Modifier.testTag("dismiss_feedback_button")
                            ) {
                                Icon(
                                    imageVector = Icons.Rounded.Close,
                                    contentDescription = "Fechar aviso",
                                    tint = MaterialTheme.colorScheme.onSecondaryContainer
                                )
                            }
                        }
                    }
                }
            }

            // Native Services & Permissions Control Card
            item {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    shape = MaterialTheme.shapes.large,
                    colors = CardDefaults.cardColors(
                        containerColor = MaterialTheme.colorScheme.surfaceContainer
                    )
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Column(modifier = Modifier.weight(1f)) {
                                Text(
                                    text = "Serviços Nativos e Permissões",
                                    style = MaterialTheme.typography.titleLarge
                                )
                                Text(
                                    text = "Somente leitura — nunca aceita nem recusa corridas automaticamente.",
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = MaterialTheme.colorScheme.onSurfaceVariant
                                )
                            }
                            Icon(
                                imageVector = Icons.Rounded.Security,
                                contentDescription = "Transparência de permissões",
                                tint = MaterialTheme.colorScheme.secondary
                            )
                        }

                        Spacer(modifier = Modifier.height(12.dp))

                        PermissionActionRow(
                            icon = Icons.Rounded.AccessibilityNew,
                            title = "Acessibilidade (Leitura Mob Lets + OCR)",
                            subtitle = "Lê preço, retirada e destino exibidos na tela",
                            granted = state.permissions.accessibilityEnabled,
                            actionLabel = if (state.permissions.accessibilityEnabled) "Configurar" else "Ativar",
                            testTag = "accessibility_permission_button",
                            onClick = {
                                context.startActivity(Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS))
                            }
                        )

                        Spacer(modifier = Modifier.height(8.dp))

                        PermissionActionRow(
                            icon = Icons.Rounded.Layers,
                            title = "Janela Flutuante (Overlay)",
                            subtitle = "Exibe semáforo e R$/km sobre o app Mob Lets",
                            granted = state.permissions.overlayGranted,
                            actionLabel = if (state.permissions.overlayGranted) "Concedida" else "Permitir",
                            testTag = "overlay_permission_button",
                            onClick = {
                                val intent = Intent(
                                    Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                                    Uri.parse("package:${context.packageName}")
                                )
                                context.startActivity(intent)
                            }
                        )

                        Spacer(modifier = Modifier.height(8.dp))

                        PermissionActionRow(
                            icon = Icons.Rounded.LocationOn,
                            title = "Localização GPS em Tempo Real",
                            subtitle = "Calcula Etapa 1 (sua posição até a loja)",
                            granted = state.permissions.locationGranted,
                            actionLabel = if (state.permissions.locationGranted) "Ativa" else "Permitir",
                            testTag = "location_permission_button",
                            onClick = {
                                locationLauncher.launch(
                                    arrayOf(
                                        Manifest.permission.ACCESS_FINE_LOCATION,
                                        Manifest.permission.ACCESS_COARSE_LOCATION
                                    )
                                )
                            }
                        )

                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                            Spacer(modifier = Modifier.height(8.dp))
                            PermissionActionRow(
                                icon = Icons.Rounded.NotificationsActive,
                                title = "Notificações do Serviço (Android 15)",
                                subtitle = "Mantém a janela flutuante ativa em segundo plano",
                                granted = state.permissions.notificationsGranted,
                                actionLabel = if (state.permissions.notificationsGranted) "Ativa" else "Permitir",
                                testTag = "notification_permission_button",
                                onClick = {
                                    notificationLauncher.launch(Manifest.permission.POST_NOTIFICATIONS)
                                }
                            )
                        }

                        Spacer(modifier = Modifier.height(14.dp))

                        Button(
                            onClick = onToggleOverlay,
                            modifier = Modifier
                                .fillMaxWidth()
                                .height(50.dp)
                                .testTag("toggle_overlay_service_button"),
                            colors = ButtonDefaults.buttonColors(
                                containerColor = if (state.runtime.isOverlayServiceRunning) {
                                    rotaColors.redContainer
                                } else {
                                    MaterialTheme.colorScheme.primary
                                },
                                contentColor = if (state.runtime.isOverlayServiceRunning) {
                                    rotaColors.onRedContainer
                                } else {
                                    MaterialTheme.colorScheme.onPrimary
                                }
                            )
                        ) {
                            Icon(
                                imageVector = if (state.runtime.isOverlayServiceRunning) {
                                    Icons.Rounded.Stop
                                } else {
                                    Icons.Rounded.PlayArrow
                                },
                                contentDescription = null
                            )
                            Spacer(modifier = Modifier.width(8.dp))
                            Text(
                                text = if (state.runtime.isOverlayServiceRunning) {
                                    "Parar Janela Flutuante"
                                } else {
                                    "Iniciar Janela Flutuante sobre Mob Lets"
                                },
                                style = MaterialTheme.typography.labelLarge
                            )
                        }
                    }
                }
            }

            // Latest Analyzed Offer Hero Card
            item {
                when {
                    state.runtime.isAnalyzing -> {
                        Card(
                            modifier = Modifier.fillMaxWidth(),
                            shape = MaterialTheme.shapes.large,
                            colors = CardDefaults.cardColors(
                                containerColor = MaterialTheme.colorScheme.surfaceContainer
                            ),
                            border = BorderStroke(1.dp, rotaColors.routeCyan.copy(alpha = 0.6f))
                        ) {
                            Column(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(20.dp),
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                CircularProgressIndicator(modifier = Modifier.size(34.dp))
                                Spacer(modifier = Modifier.height(10.dp))
                                Text(
                                    text = "Calculando rota real em Montes Claros...",
                                    style = MaterialTheme.typography.titleMedium
                                )
                                Spacer(modifier = Modifier.height(4.dp))
                                Text(
                                    text = state.runtime.lastStatusMessage,
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = MaterialTheme.colorScheme.onSurfaceVariant
                                )
                            }
                        }
                    }

                    !state.runtime.lastAnalysisError.isNullOrBlank() -> {
                        Card(
                            modifier = Modifier
                                .fillMaxWidth()
                                .testTag("unresolved_address_card"),
                            shape = MaterialTheme.shapes.large,
                            colors = CardDefaults.cardColors(
                                containerColor = rotaColors.yellowContainer.copy(alpha = 0.45f)
                            ),
                            border = BorderStroke(1.5.dp, rotaColors.yellow)
                        ) {
                            Column(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(18.dp)
                            ) {
                                Row(verticalAlignment = Alignment.CenterVertically) {
                                    Icon(
                                        imageVector = Icons.Rounded.LocationOn,
                                        contentDescription = "Endereço não localizado",
                                        tint = rotaColors.yellow,
                                        modifier = Modifier.size(26.dp)
                                    )
                                    Spacer(modifier = Modifier.width(8.dp))
                                    Text(
                                        text = "Endereço não localizado — cálculo bloqueado",
                                        style = MaterialTheme.typography.titleMedium,
                                        color = rotaColors.onYellowContainer,
                                        fontWeight = FontWeight.Bold
                                    )
                                }
                                Spacer(modifier = Modifier.height(8.dp))
                                Text(
                                    text = state.runtime.lastAnalysisError.orEmpty(),
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = MaterialTheme.colorScheme.onSurface
                                )
                                Spacer(modifier = Modifier.height(4.dp))
                                Text(
                                    text = "Nenhuma coordenada artificial foi usada. Informe rua e bairro válidos em Montes Claros.",
                                    style = MaterialTheme.typography.labelMedium,
                                    color = MaterialTheme.colorScheme.onSurfaceVariant
                                )
                            }
                        }
                    }

                    state.latestOffer != null -> {
                        TrafficLightDecisionCard(offer = state.latestOffer)
                    }

                    else -> {
                        Card(
                            modifier = Modifier.fillMaxWidth(),
                            shape = MaterialTheme.shapes.large,
                            colors = CardDefaults.cardColors(
                                containerColor = MaterialTheme.colorScheme.surfaceContainer
                            )
                        ) {
                            Column(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(20.dp),
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                Icon(
                                    imageVector = Icons.Rounded.Route,
                                    contentDescription = "Aguardando primeira análise",
                                    tint = MaterialTheme.colorScheme.secondary,
                                    modifier = Modifier.size(38.dp)
                                )
                                Spacer(modifier = Modifier.height(8.dp))
                                Text(
                                    text = "Nenhuma oferta analisada ainda",
                                    style = MaterialTheme.typography.titleMedium
                                )
                                Spacer(modifier = Modifier.height(4.dp))
                                Text(
                                    text = "Ative a Acessibilidade para detectar corridas do Mob Lets automaticamente ou use o Analisador Manual / OCR abaixo.",
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = MaterialTheme.colorScheme.onSurfaceVariant
                                )
                            }
                        }
                    }
                }
            }

            // Manual Offer & OCR Lab Card
            item {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    shape = MaterialTheme.shapes.large,
                    colors = CardDefaults.cardColors(
                        containerColor = MaterialTheme.colorScheme.surfaceContainer
                    )
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Text(
                            text = "Análise Manual & Fallback OCR (ML Kit)",
                            style = MaterialTheme.typography.titleLarge
                        )
                        Text(
                            text = "Teste rotas completas em Montes Claros ou selecione um print de oferta para extração via OCR.",
                            style = MaterialTheme.typography.bodyMedium,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )

                        Spacer(modifier = Modifier.height(10.dp))

                        Text(
                            text = "Cenários rápidos em Montes Claros:",
                            style = MaterialTheme.typography.labelMedium,
                            color = MaterialTheme.colorScheme.secondary
                        )
                        Spacer(modifier = Modifier.height(6.dp))
                        FlowRow(
                            horizontalArrangement = Arrangement.spacedBy(8.dp),
                            verticalArrangement = Arrangement.spacedBy(6.dp)
                        ) {
                            AssistChip(
                                onClick = {
                                    priceInput = "18,50"
                                    pickupInput = "Av. Deputado Esteves Rodrigues, 450 - Centro"
                                    customerInput = "Av. José Corrêa Machado, 920 - Ibituruna"
                                },
                                label = { Text("Lucrativa (Centro → Ibituruna)") },
                                modifier = Modifier.testTag("preset_green_button")
                            )
                            AssistChip(
                                onClick = {
                                    priceInput = "17,00"
                                    pickupInput = "Rua Tupinambás, 210 - Melo"
                                    customerInput = "Rua Santa Lúcia, 340 - Maracanã"
                                },
                                label = { Text("Atenção (Melo → Maracanã)") },
                                modifier = Modifier.testTag("preset_yellow_button")
                            )
                            AssistChip(
                                onClick = {
                                    priceInput = "22,00"
                                    pickupInput = "Praça Dr. Carlos Versiani, 80 - Centro"
                                    customerInput = "Rua Principal, 150 - Village do Lago"
                                },
                                label = { Text("Bairro Evitado (Village do Lago)") },
                                modifier = Modifier.testTag("preset_red_button")
                            )
                        }

                        Spacer(modifier = Modifier.height(12.dp))

                        OutlinedTextField(
                            value = priceInput,
                            onValueChange = { priceInput = it },
                            label = { Text("Valor da corrida (R$)") },
                            prefix = { Text("R$ ") },
                            singleLine = true,
                            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal),
                            modifier = Modifier
                                .fillMaxWidth()
                                .testTag("manual_price_input")
                        )

                        Spacer(modifier = Modifier.height(8.dp))

                        OutlinedTextField(
                            value = pickupInput,
                            onValueChange = { pickupInput = it },
                            label = { Text("Endereço de Retirada (Loja)") },
                            singleLine = true,
                            modifier = Modifier
                                .fillMaxWidth()
                                .testTag("manual_pickup_input")
                        )

                        Spacer(modifier = Modifier.height(8.dp))

                        OutlinedTextField(
                            value = customerInput,
                            onValueChange = { customerInput = it },
                            label = { Text("Endereço de Entrega (Cliente)") },
                            singleLine = true,
                            modifier = Modifier
                                .fillMaxWidth()
                                .testTag("manual_customer_input")
                        )

                        Spacer(modifier = Modifier.height(14.dp))

                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.spacedBy(10.dp)
                        ) {
                            Button(
                                onClick = {
                                    onAnalyzeManual(priceInput, pickupInput, customerInput)
                                },
                                enabled = !state.isManualProcessing,
                                modifier = Modifier
                                    .weight(1f)
                                    .height(48.dp)
                                    .testTag("analyze_manual_button")
                            ) {
                                if (state.isManualProcessing) {
                                    CircularProgressIndicator(
                                        modifier = Modifier.size(18.dp),
                                        strokeWidth = 2.dp
                                    )
                                } else {
                                    Icon(
                                        imageVector = Icons.Rounded.Analytics,
                                        contentDescription = null,
                                        modifier = Modifier.size(18.dp)
                                    )
                                }
                                Spacer(modifier = Modifier.width(6.dp))
                                Text("Analisar Rota")
                            }

                            OutlinedButton(
                                onClick = {
                                    photoPickerLauncher.launch(
                                        PickVisualMediaRequest(ActivityResultContracts.PickVisualMedia.ImageOnly)
                                    )
                                },
                                enabled = !state.isManualProcessing,
                                modifier = Modifier
                                    .weight(1f)
                                    .height(48.dp)
                                    .testTag("ocr_photo_picker_button")
                            ) {
                                Icon(
                                    imageVector = Icons.Rounded.DocumentScanner,
                                    contentDescription = null,
                                    modifier = Modifier.size(18.dp)
                                )
                                Spacer(modifier = Modifier.width(6.dp))
                                Text("Ler Print OCR")
                            }
                        }
                    }
                }
            }
        }
    }
}

@Composable
private fun PermissionActionRow(
    icon: ImageVector,
    title: String,
    subtitle: String,
    granted: Boolean,
    actionLabel: String,
    testTag: String,
    onClick: () -> Unit
) {
    val rotaColors = LocalRotaColors.current
    Surface(
        shape = MaterialTheme.shapes.medium,
        color = MaterialTheme.colorScheme.surfaceContainerHigh.copy(alpha = 0.65f)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 12.dp, vertical = 10.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(
                imageVector = if (granted) Icons.Rounded.CheckCircle else icon,
                contentDescription = title,
                tint = if (granted) rotaColors.green else MaterialTheme.colorScheme.secondary,
                modifier = Modifier.size(22.dp)
            )
            Spacer(modifier = Modifier.width(10.dp))
            Column(modifier = Modifier.weight(1f)) {
                Text(
                    text = title,
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.SemiBold
                )
                Text(
                    text = subtitle,
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
            Spacer(modifier = Modifier.width(8.dp))
            FilledTonalButton(
                onClick = onClick,
                modifier = Modifier
                    .height(48.dp)
                    .testTag(testTag),
                contentPadding = PaddingValues(horizontal = 12.dp)
            ) {
                Text(text = actionLabel, style = MaterialTheme.typography.labelLarge)
            }
        }
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/ui/screens/HistoryScreen.kt
package com.example.ui.screens

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.DeleteOutline
import androidx.compose.material.icons.rounded.DeleteSweep
import androidx.compose.material.icons.rounded.History
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.FilterChip
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.example.data.local.AnalyzedOfferEntity
import com.example.data.local.TrafficLightDecision
import com.example.ui.components.RouteFourLegDiagram
import com.example.ui.theme.LocalRotaColors
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

@Composable
fun HistoryScreen(
    offers: List<AnalyzedOfferEntity>,
    onDeleteOffer: (Long) -> Unit,
    onClearAll: () -> Unit,
    modifier: Modifier = Modifier
) {
    var selectedFilter by remember { mutableStateOf<String?>(null) }
    var showClearDialog by remember { mutableStateOf(false) }
    var expandedId by remember { mutableStateOf<Long?>(null) }

    val filteredOffers = remember(offers, selectedFilter) {
        if (selectedFilter == null) offers else offers.filter { it.decision == selectedFilter }
    }

    val ptBr = Locale("pt", "BR")
    val avgRate = remember(offers) {
        if (offers.isEmpty()) 0.0 else offers.map { it.earningsPerKm }.average()
    }
    val greenCount = remember(offers) {
        offers.count { it.decision == TrafficLightDecision.GREEN.name }
    }

    if (showClearDialog) {
        AlertDialog(
            onDismissRequest = { showClearDialog = false },
            title = { Text("Limpar histórico?") },
            text = { Text("Todas as corridas analisadas salvas localmente serão removidas.") },
            confirmButton = {
                TextButton(
                    onClick = {
                        onClearAll()
                        showClearDialog = false
                    }
                ) {
                    Text("Limpar tudo")
                }
            },
            dismissButton = {
                TextButton(onClick = { showClearDialog = false }) {
                    Text("Cancelar")
                }
            }
        )
    }

    Box(
        modifier = modifier.fillMaxSize(),
        contentAlignment = Alignment.TopCenter
    ) {
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .widthIn(max = 680.dp),
            contentPadding = PaddingValues(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            item {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column {
                        Text(
                            text = "Histórico de Ofertas",
                            style = MaterialTheme.typography.headlineMedium
                        )
                        Text(
                            text = "Armazenamento local offline via Room",
                            style = MaterialTheme.typography.bodyMedium,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                    if (offers.isNotEmpty()) {
                        IconButton(
                            onClick = { showClearDialog = true },
                            modifier = Modifier.testTag("clear_history_button")
                        ) {
                            Icon(
                                imageVector = Icons.Rounded.DeleteSweep,
                                contentDescription = "Limpar histórico"
                            )
                        }
                    }
                }
            }

            item {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(10.dp)
                ) {
                    SummaryMetricCard(
                        title = "Analisadas",
                        value = offers.size.toString(),
                        modifier = Modifier.weight(1f)
                    )
                    SummaryMetricCard(
                        title = "Compensam",
                        value = "$greenCount",
                        modifier = Modifier.weight(1f)
                    )
                    SummaryMetricCard(
                        title = "Média R$/km",
                        value = String.format(ptBr, "R$ %.2f", avgRate),
                        modifier = Modifier.weight(1f)
                    )
                }
            }

            item {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    FilterChip(
                        selected = selectedFilter == null,
                        onClick = { selectedFilter = null },
                        label = { Text("Todas") },
                        modifier = Modifier.testTag("filter_all_offers")
                    )
                    FilterChip(
                        selected = selectedFilter == TrafficLightDecision.GREEN.name,
                        onClick = { selectedFilter = TrafficLightDecision.GREEN.name },
                        label = { Text("Verde") },
                        modifier = Modifier.testTag("filter_green_offers")
                    )
                    FilterChip(
                        selected = selectedFilter == TrafficLightDecision.YELLOW.name,
                        onClick = { selectedFilter = TrafficLightDecision.YELLOW.name },
                        label = { Text("Amarela") },
                        modifier = Modifier.testTag("filter_yellow_offers")
                    )
                    FilterChip(
                        selected = selectedFilter == TrafficLightDecision.RED.name,
                        onClick = { selectedFilter = TrafficLightDecision.RED.name },
                        label = { Text("Vermelha") },
                        modifier = Modifier.testTag("filter_red_offers")
                    )
                }
            }

            if (filteredOffers.isEmpty()) {
                item {
                    Card(
                        modifier = Modifier.fillMaxWidth(),
                        colors = CardDefaults.cardColors(
                            containerColor = MaterialTheme.colorScheme.surfaceContainer
                        )
                    ) {
                        Column(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(28.dp),
                            horizontalAlignment = Alignment.CenterHorizontally
                        ) {
                            Icon(
                                imageVector = Icons.Rounded.History,
                                contentDescription = "Sem histórico",
                                tint = MaterialTheme.colorScheme.secondary,
                                modifier = Modifier.size(40.dp)
                            )
                            Spacer(modifier = Modifier.height(8.dp))
                            Text(
                                text = "Nenhuma oferta registrada nesta categoria",
                                style = MaterialTheme.typography.titleMedium
                            )
                            Text(
                                text = "As corridas detectadas pelo Mob Lets ou testadas manualmente ficam salvas aqui.",
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.onSurfaceVariant
                            )
                        }
                    }
                }
            } else {
                items(filteredOffers, key = { it.id }) { offer ->
                    HistoryOfferItem(
                        offer = offer,
                        expanded = expandedId == offer.id,
                        onToggleExpand = {
                            expandedId = if (expandedId == offer.id) null else offer.id
                        },
                        onDelete = { onDeleteOffer(offer.id) }
                    )
                }
            }
        }
    }
}

@Composable
private fun SummaryMetricCard(
    title: String,
    value: String,
    modifier: Modifier = Modifier
) {
    Card(
        modifier = modifier,
        shape = MaterialTheme.shapes.medium,
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surfaceContainer
        )
    ) {
        Column(modifier = Modifier.padding(12.dp)) {
            Text(
                text = title,
                style = MaterialTheme.typography.labelSmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
            Spacer(modifier = Modifier.height(4.dp))
            Text(
                text = value,
                style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold
            )
        }
    }
}

@Composable
private fun HistoryOfferItem(
    offer: AnalyzedOfferEntity,
    expanded: Boolean,
    onToggleExpand: () -> Unit,
    onDelete: () -> Unit
) {
    val rotaColors = LocalRotaColors.current
    val ptBr = Locale("pt", "BR")
    val dateFormat = SimpleDateFormat("dd/MM HH:mm", ptBr)

    val (accent, badgeLabel) = when (offer.decision) {
        TrafficLightDecision.GREEN.name -> rotaColors.green to "COMPENSA"
        TrafficLightDecision.YELLOW.name -> rotaColors.yellow to "ATENÇÃO"
        else -> rotaColors.red to "NÃO COMPENSA"
    }

    Card(
        onClick = onToggleExpand,
        modifier = Modifier
            .fillMaxWidth()
            .testTag("history_offer_card_${offer.id}"),
        shape = MaterialTheme.shapes.medium,
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surfaceContainer
        ),
        border = BorderStroke(1.dp, accent.copy(alpha = 0.45f))
    ) {
        Column(modifier = Modifier.padding(14.dp)) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Surface(
                        shape = MaterialTheme.shapes.small,
                        color = accent.copy(alpha = 0.16f)
                    ) {
                        Text(
                            text = badgeLabel,
                            style = MaterialTheme.typography.labelMedium,
                            color = accent,
                            modifier = Modifier.padding(horizontal = 8.dp, vertical = 4.dp)
                        )
                    }
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        text = dateFormat.format(Date(offer.timestamp)),
                        style = MaterialTheme.typography.labelMedium,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }

                IconButton(
                    onClick = onDelete,
                    modifier = Modifier.testTag("delete_offer_${offer.id}")
                ) {
                    Icon(
                        imageVector = Icons.Rounded.DeleteOutline,
                        contentDescription = "Remover oferta",
                        tint = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            }

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Column(modifier = Modifier.weight(1f)) {
                    Text(
                        text = "${offer.pickupNeighborhood} → ${offer.customerNeighborhood}",
                        style = MaterialTheme.typography.titleMedium,
                        fontWeight = FontWeight.SemiBold
                    )
                    val routeModeLabel = if (offer.routeSource == "OSRM_REAL_ROADS") {
                        "Rota OSRM"
                    } else {
                        "Estimada"
                    }
                    Text(
                        text = String.format(
                            ptBr,
                            "R$ %.2f • %.1f km (%s)",
                            offer.offerPriceBrl,
                            offer.totalKm,
                            routeModeLabel
                        ),
                        style = MaterialTheme.typography.bodyMedium,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
                Text(
                    text = String.format(ptBr, "R$ %.2f/km", offer.earningsPerKm),
                    style = MaterialTheme.typography.titleLarge,
                    color = accent,
                    fontWeight = FontWeight.Bold
                )
            }

            if (expanded) {
                Spacer(modifier = Modifier.height(10.dp))
                Text(
                    text = offer.decisionReason,
                    style = MaterialTheme.typography.bodyMedium
                )
                Spacer(modifier = Modifier.height(10.dp))
                RouteFourLegDiagram(offer = offer)
            }
        }
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/example/ui/screens/NeighborhoodsScreen.kt
package com.example.ui.screens

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.rounded.Add
import androidx.compose.material.icons.rounded.DeleteOutline
import androidx.compose.material.icons.rounded.Search
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.FilterChip
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.example.data.local.NeighborhoodRuleEntity
import com.example.data.local.NeighborhoodStatus
import com.example.ui.theme.LocalRotaColors

@Composable
fun NeighborhoodsScreen(
    rules: List<NeighborhoodRuleEntity>,
    onUpdateStatus: (name: String, status: NeighborhoodStatus, notes: String) -> Unit,
    onAddNeighborhood: (name: String, status: NeighborhoodStatus, notes: String) -> Unit,
    onDeleteCustom: (name: String) -> Unit,
    modifier: Modifier = Modifier
) {
    var searchQuery by remember { mutableStateOf("") }
    var filterStatus by remember { mutableStateOf<NeighborhoodStatus?>(null) }
    var showAddDialog by remember { mutableStateOf(false) }

    val filtered = remember(rules, searchQuery, filterStatus) {
        rules.filter { rule ->
            val matchesQuery = searchQuery.isBlank() ||
                rule.name.contains(searchQuery, ignoreCase = true) ||
                rule.notes.contains(searchQuery, ignoreCase = true)
            val matchesStatus = filterStatus == null || rule.status == filterStatus?.name
            matchesQuery && matchesStatus
        }
    }

    if (showAddDialog) {
        AddNeighborhoodDialog(
            onDismiss = { showAddDialog = false },
            onSave = { name, status, notes ->
                onAddNeighborhood(name, status, notes)
                showAddDialog = false
            }
        )
    }

    Scaffold(
        modifier = modifier.fillMaxSize(),
        floatingActionButton = {
            FloatingActionButton(
                onClick = { showAddDialog = true },
                modifier = Modifier.testTag("add_neighborhood_fab")
            ) {
                Icon(
                    imageVector = Icons.Rounded.Add,
                    contentDescription = "Adicionar bairro"
                )
            }
        }
    ) { innerPadding ->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding),
            contentAlignment = Alignment.TopCenter
        ) {
            LazyColumn(
                modifier = Modifier
                    .fillMaxSize()
                    .widthIn(max = 680.dp),
                contentPadding = PaddingValues(16.dp),
                verticalArrangement = Arrangement.spacedBy(10.dp)
            ) {
                item {
                    Text(
                        text = "Bairros de Montes Claros",
                        style = MaterialTheme.typography.headlineMedium
                    )
                    Text(
                        text = "Defina bairros preferidos e áreas perigosas ou evitadas. Bairros evitados marcam a oferta como VERMELHO automaticamente.",
                        style = MaterialTheme.typography.bodyMedium,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }

                item {
                    OutlinedTextField(
                        value = searchQuery,
                        onValueChange = { searchQuery = it },
                        label = { Text("Buscar bairro...") },
                        leadingIcon = {
                            Icon(imageVector = Icons.Rounded.Search, contentDescription = null)
                        },
                        singleLine = true,
                        modifier = Modifier
                            .fillMaxWidth()
                            .testTag("search_neighborhood_input")
                    )
                }

                item {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(8.dp)
                    ) {
                        FilterChip(
                            selected = filterStatus == null,
                            onClick = { filterStatus = null },
                            label = { Text("Todos") }
                        )
                        FilterChip(
                            selected = filterStatus == NeighborhoodStatus.AVOIDED,
                            onClick = { filterStatus = NeighborhoodStatus.AVOIDED },
                            label = { Text("Evitados") }
                        )
                        FilterChip(
                            selected = filterStatus == NeighborhoodStatus.PREFERRED,
                            onClick = { filterStatus = NeighborhoodStatus.PREFERRED },
                            label = { Text("Preferidos") }
                        )
                        FilterChip(
                            selected = filterStatus == NeighborhoodStatus.NEUTRAL,
                            onClick = { filterStatus = NeighborhoodStatus.NEUTRAL },
                            label = { Text("Neutros") }
                        )
                    }
                }

                items(filtered, key = { it.name }) { rule ->
                    NeighborhoodRuleCard(
                        rule = rule,
                        onStatusSelected = { newStatus ->
                            onUpdateStatus(rule.name, newStatus, rule.notes)
                        },
                        onDelete = { onDeleteCustom(rule.name) }
                    )
                }
            }
        }
    }
}

@Composable
private fun NeighborhoodRuleCard(
    rule: NeighborhoodRuleEntity,
    onStatusSelected: (NeighborhoodStatus) -> Unit,
    onDelete: () -> Unit
) {
    val rotaColors = LocalRotaColors.current
    val currentStatus = NeighborhoodStatus.entries.firstOrNull { it.name == rule.status }
        ?: NeighborhoodStatus.NEUTRAL

    val borderColor = when (currentStatus) {
        NeighborhoodStatus.PREFERRED -> rotaColors.green.copy(alpha = 0.5f)
        NeighborhoodStatus.AVOIDED -> rotaColors.red.copy(alpha = 0.6f)
        NeighborhoodStatus.NEUTRAL -> MaterialTheme.colorScheme.outlineVariant
    }

    Card(
        modifier = Modifier.fillMaxWidth(),
        shape = MaterialTheme.shapes.medium,
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surfaceContainer
        ),
        border = BorderStroke(1.dp, borderColor)
    ) {
        Column(modifier = Modifier.padding(14.dp)) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Column(modifier = Modifier.weight(1f)) {
                    Text(
                        text = rule.name,
                        style = MaterialTheme.typography.titleMedium,
                        fontWeight = FontWeight.SemiBold
                    )
                    if (rule.notes.isNotBlank()) {
                        Text(
                            text = rule.notes,
                            style = MaterialTheme.typography.bodyMedium,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                }
                if (rule.isCustom) {
                    IconButton(onClick = onDelete) {
                        Icon(
                            imageVector = Icons.Rounded.DeleteOutline,
                            contentDescription = "Remover bairro customizado"
                        )
                    }
                }
            }

            Spacer(modifier = Modifier.height(8.dp))

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                FilterChip(
                    selected = currentStatus == NeighborhoodStatus.PREFERRED,
                    onClick = { onStatusSelected(NeighborhoodStatus.PREFERRED) },
                    label = { Text("Preferido") },
                    modifier = Modifier.weight(1f)
                )
                FilterChip(
                    selected = currentStatus == NeighborhoodStatus.NEUTRAL,
                    onClick = { onStatusSelected(NeighborhoodStatus.NEUTRAL) },
                    label = { Text("Neutro") },
                    modifier = Modifier.weight(1f)
                )
                FilterChip(
                    selected = currentStatus == NeighborhoodStatus.AVOIDED,
                    onClick = { onStatusSelected(NeighborhoodStatus.AVOIDED) },
                    label = { Text("Evitado") },
                    modifier = Modifier.weight(1f)
                )
            }
        }
    }
}

@Composable
private fun AddNeighborhoodDialog(
    onDismiss: () -> Unit,
    onSave: (name: String, status: NeighborhoodStatus, notes: String) -> Unit
) {
    var name by remember { mutableStateOf("") }
    var notes by remember { mutableStateOf("") }
    var status by remember { mutableStateOf(NeighborhoodStatus.AVOIDED) }

    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Adicionar Bairro") },
        text = {
            Column(verticalArrangement = Arrangement.spacedBy(10.dp)) {
                OutlinedTextField(
                    value = name,
                    onValueChange = { name = it },
                    label = { Text("Nome do bairro") },
                    singleLine = true,
                    modifier = Modifier.fillMaxWidth()
                )
                OutlinedTextField(
                    value = notes,
                    onValueChange = { notes = it },
                    label = { Text("Observação (opcional)") },
                    singleLine = true,
                    modifier = Modifier.fillMaxWidth()
                )
                Row(horizontalArrangement = Arrangement.spacedBy(6.dp)) {
                    FilterChip(
                        selected = status == NeighborhoodStatus.PREFERRED,
                        onClick = { status = NeighborhoodStatus.PREFERRED },
                        label = { Text("Preferido") }
                    )
                    FilterChip(
                        selected = status == NeighborhoodStatus.AVOIDED,
                        onClick = { status = NeighborhoodStatus.AVOIDED },
                        label = { Text("Evitado") }
                    )
                }
            }
        },
        confirmButton = {
            Button(
                onClick = { if (name.isNotBlank()) onSave(name, status, notes) }
            ) {
                Text("Salvar")
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) {
                Text("Cancelar")
            }
        }
    )
}
EOF

cat << 'EOF' > app/src/main/java/com/example/ui/screens/SettingsScreen.kt
package com.example.ui.screens

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.AssistChip
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Slider
import androidx.compose.material3.Switch
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.testTag
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.example.data.preferences.DriverSettings
import com.example.ui.theme.LocalRotaColors
import java.util.Locale

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun SettingsScreen(
    settings: DriverSettings,
    onUpdateTargetPerKm: (Double) -> Unit,
    onToggleOcrFallback: (Boolean) -> Unit,
    onToggleOsrmRouting: (Boolean) -> Unit,
    onToggleAutoShowOverlay: (Boolean) -> Unit,
    onToggleStrictMobLets: (Boolean) -> Unit,
    modifier: Modifier = Modifier
) {
    val rotaColors = LocalRotaColors.current
    val ptBr = Locale("pt", "BR")

    Box(
        modifier = modifier.fillMaxSize(),
        contentAlignment = Alignment.TopCenter
    ) {
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .widthIn(max = 680.dp),
            contentPadding = PaddingValues(16.dp),
            verticalArrangement = Arrangement.spacedBy(14.dp)
        ) {
            item {
                Text(
                    text = "Ajustes e Transparência",
                    style = MaterialTheme.typography.headlineMedium
                )
                Text(
                    text = "Calibre sua meta mínima por km e os módulos de leitura e roteamento.",
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }

            item {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    shape = MaterialTheme.shapes.large,
                    colors = CardDefaults.cardColors(
                        containerColor = MaterialTheme.colorScheme.surfaceContainer
                    )
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Text(
                                text = "Meta Mínima por Quilômetro",
                                style = MaterialTheme.typography.titleMedium,
                                fontWeight = FontWeight.SemiBold
                            )
                            Text(
                                text = String.format(ptBr, "R$ %.2f / km", settings.minTargetPerKm),
                                style = MaterialTheme.typography.titleLarge,
                                color = rotaColors.green
                            )
                        }

                        Spacer(modifier = Modifier.height(6.dp))
                        Slider(
                            value = settings.minTargetPerKm.toFloat(),
                            onValueChange = { raw ->
                                val rounded = Math.round(raw * 20.0) / 20.0
                                onUpdateTargetPerKm(rounded)
                            },
                            valueRange = 1.20f..3.50f,
                            modifier = Modifier.testTag("target_per_km_slider")
                        )

                        FlowRow(
                            horizontalArrangement = Arrangement.spacedBy(8.dp)
                        ) {
                            listOf(1.70, 1.90, 2.20, 2.50).forEach { preset ->
                                val label = if (preset == 1.90) "R$ 1,90 (Padrão)" else String.format(ptBr, "R$ %.2f", preset)
                                AssistChip(
                                    onClick = { onUpdateTargetPerKm(preset) },
                                    label = { Text(label) }
                                )
                            }
                        }
                    }
                }
            }

            item {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    shape = MaterialTheme.shapes.large,
                    colors = CardDefaults.cardColors(
                        containerColor = MaterialTheme.colorScheme.surfaceContainer
                    )
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Text(
                            text = "Motor de Detecção e Rota",
                            style = MaterialTheme.typography.titleMedium,
                            fontWeight = FontWeight.SemiBold
                        )
                        Spacer(modifier = Modifier.height(10.dp))

                        SettingToggleRow(
                            title = "Fallback OCR (Google ML Kit)",
                            subtitle = "Usa captura de tela via Acessibilidade (Android 11+) quando o texto da tela não estiver acessível.",
                            checked = settings.ocrFallbackEnabled,
                            onCheckedChange = onToggleOcrFallback,
                            testTag = "toggle_ocr_fallback"
                        )
                        HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp))

                        SettingToggleRow(
                            title = "Rotas Reais via API OSRM",
                            subtitle = "Calcula distância viária real de carro/moto em Montes Claros com fallback offline automático.",
                            checked = settings.useOsrmRoadRouting,
                            onCheckedChange = onToggleOsrmRouting,
                            testTag = "toggle_osrm_routing"
                        )
                        HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp))

                        SettingToggleRow(
                            title = "Abrir Janela Flutuante ao Detectar Oferta",
                            subtitle = "Atualiza ou exibe o painel sobre o Mob Lets quando uma nova oferta é analisada.",
                            checked = settings.autoShowOverlayOnOffer,
                            onCheckedChange = onToggleAutoShowOverlay,
                            testTag = "toggle_auto_overlay"
                        )
                        HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp))

                        SettingToggleRow(
                            title = "Filtrar Estritamente Pacotes Mob Lets",
                            subtitle = "Quando desligado, analisa telas de oferta compatíveis em qualquer app de entrega.",
                            checked = settings.strictMobLetsPackageFilter,
                            onCheckedChange = onToggleStrictMobLets,
                            testTag = "toggle_strict_package"
                        )
                    }
                }
            }

            item {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    shape = MaterialTheme.shapes.large,
                    colors = CardDefaults.cardColors(
                        containerColor = MaterialTheme.colorScheme.surfaceContainer
                    ),
                    border = BorderStroke(1.dp, MaterialTheme.colorScheme.secondary.copy(alpha = 0.4f))
                ) {
                    Column(
                        modifier = Modifier.padding(16.dp),
                        verticalArrangement = Arrangement.spacedBy(8.dp)
                    ) {
                        Text(
                            text = "Transparência: Permissões e APIs Externas",
                            style = MaterialTheme.typography.titleMedium,
                            color = MaterialTheme.colorScheme.secondary,
                            fontWeight = FontWeight.Bold
                        )
                        DisclosureItem(
                            title = "1. AccessibilityService (Android 15)",
                            body = "Permissão especial do sistema para ler preço, loja e endereço do cliente na tela do Mob Lets e acionar takeScreenshot() para OCR. Nunca executa cliques ou aceita/recusa corridas."
                        )
                        DisclosureItem(
                            title = "2. SYSTEM_ALERT_WINDOW + ForegroundService (specialUse)",
                            body = "Permite desenhar o semáforo flutuante (VERDE/AMARELO/VERMELHO) sobre o Mob Lets enquanto o motorista dirige."
                        )
                        DisclosureItem(
                            title = "3. ACCESS_FINE_LOCATION (GPS)",
                            body = "Opcional: obtém a posição atual do motorista para a Etapa 1. Se negada, usa o Centro de Montes Claros como ponto de partida."
                        )
                        DisclosureItem(
                            title = "4. APIs Externas e On-Device",
                            body = "• OSRM Public Driving API (router.project-osrm.org) + Android Geocoder: calcula quilometragem real das 3 etapas (sem necessidade de chave paga; possui fallback urbano offline).\n• Google ML Kit Text Recognition: OCR executado 100% no dispositivo."
                        )
                    }
                }
            }
        }
    }
}

@Composable
private fun SettingToggleRow(
    title: String,
    subtitle: String,
    checked: Boolean,
    onCheckedChange: (Boolean) -> Unit,
    testTag: String
) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Column(modifier = Modifier.weight(1f).padding(end = 12.dp)) {
            Text(text = title, style = MaterialTheme.typography.titleMedium)
            Text(
                text = subtitle,
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
        Switch(
            checked = checked,
            onCheckedChange = onCheckedChange,
            modifier = Modifier.testTag(testTag)
        )
    }
}

@Composable
private fun DisclosureItem(title: String, body: String) {
    Column {
        Text(
            text = title,
            style = MaterialTheme.typography.labelLarge,
            color = MaterialTheme.colorScheme.onSurface
        )
        Text(
            text = body,
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
    }
}
EOF

cat << 'EOF' > app/src/test/java/com/example/ExampleUnitTest.kt
package com.example

import org.junit.Assert.*
import org.junit.Test

class ExampleUnitTest {
  @Test
  fun addition_isCorrect() {
    assertEquals(4, 2 + 2)
  }
}
EOF

cat << 'EOF' > app/src/test/java/com/example/ExampleRobolectricTest.kt
package com.example

import android.content.Context
import androidx.test.core.app.ApplicationProvider
import org.junit.Assert.assertEquals
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [36])
class ExampleRobolectricTest {

  @Test
  fun `read string from context`() {
    val context = ApplicationProvider.getApplicationContext<Context>()
    val appName = context.getString(R.string.app_name)
    assertEquals("Rota Inteligente IA", appName)
  }
}
EOF

cat << 'EOF' > app/src/test/java/com/example/OfferEngineUnitTest.kt
package com.example

import android.content.Context
import androidx.test.core.app.ApplicationProvider
import com.example.data.InMemoryGeoCacheStore
import com.example.data.local.AnalyzedOfferEntity
import com.example.data.local.OfferCaptureSource
import com.example.data.local.TrafficLightDecision
import com.example.data.preferences.DriverSettings
import com.example.domain.GeoPoint
import com.example.domain.GeocoderPlaceMetadata
import com.example.domain.MontesClarosGeoCatalog
import com.example.domain.NeighborhoodConfidence
import com.example.domain.OfferDecisionEngine
import com.example.domain.OfferParser
import com.example.domain.OsrmLeg
import com.example.domain.OsrmRoute
import com.example.domain.OsrmRouteResponse
import com.example.domain.OsrmRoutingApi
import com.example.domain.RouteCalculationResult
import com.example.domain.RouteCalculator
import com.example.domain.RouteResolutionResult
import com.example.service.ServiceRuntimeBus
import kotlinx.coroutines.async
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config
import java.util.concurrent.atomic.AtomicInteger

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [36])
class OfferEngineUnitTest {

    @Test
    fun `parser extracts Mob Lets price, pickup, customer and never fabricates missing pickup`() {
        val sampleText = """
            Mob Lets Entregador
            Nova Oferta Disponível
            R$ 18,50
            Retirada: Av. Deputado Esteves Rodrigues, 450 - Centro
            Entrega: Av. José Corrêa Machado, 920 - Ibituruna
            Aceitar corrida
        """.trimIndent()

        val parsed = OfferParser.parse(sampleText, requireDeliveryKeywords = true)
        assertNotNull(parsed)
        assertEquals(18.50, parsed!!.offerPriceBrl, 0.01)
        assertTrue(parsed.pickupAddress.contains("Centro"))
        assertTrue(parsed.customerAddress.contains("Ibituruna"))

        val partialOffer = """
            Mob Lets Entregador
            R$ 15,00
            Entrega: Av. José Corrêa Machado, 920 - Ibituruna
        """.trimIndent()
        val parsedPartial = OfferParser.parse(partialOffer, requireDeliveryKeywords = true)
        assertNotNull(parsedPartial)
        assertEquals("", parsedPartial!!.pickupAddress)
        assertFalse(parsedPartial.isHighConfidence)
    }

    @Test
    fun `decision engine returns GREEN for high rate in preferred neighborhood`() {
        val result = OfferDecisionEngine.evaluateOffer(
            source = OfferCaptureSource.ACCESSIBILITY,
            rawSnippet = "test",
            offerPriceBrl = 19.00,
            pickupAddress = "Av. Deputado Esteves Rodrigues, 450 - Centro",
            customerAddress = "Av. José Corrêa Machado, 920 - Ibituruna",
            route = RouteCalculationResult(1.2, 3.1, 3.2, 7.5, "OSRM_REAL_ROADS"),
            usedGpsStart = true,
            neighborhoodRules = MontesClarosGeoCatalog.defaultRuleEntities(),
            settings = DriverSettings(minTargetPerKm = 1.90)
        )

        assertEquals(TrafficLightDecision.GREEN.name, result.decision)
        assertTrue(result.earningsPerKm >= 2.50)
    }

    @Test
    fun `decision engine returns RED when rate is below R$1_90 per km`() {
        val result = OfferDecisionEngine.evaluateOffer(
            source = OfferCaptureSource.MANUAL,
            rawSnippet = "test",
            offerPriceBrl = 12.00,
            pickupAddress = "Centro, Montes Claros",
            customerAddress = "Maracanã, Montes Claros",
            route = RouteCalculationResult(1.5, 4.0, 4.5, 10.0, "ESTIMATED_URBAN"),
            usedGpsStart = false,
            neighborhoodRules = MontesClarosGeoCatalog.defaultRuleEntities(),
            settings = DriverSettings(minTargetPerKm = 1.90)
        )

        assertEquals(TrafficLightDecision.RED.name, result.decision)
        assertEquals(1.20, result.earningsPerKm, 0.01)
    }

    @Test
    fun `decision engine returns RED when destination is an avoided neighborhood`() {
        val result = OfferDecisionEngine.evaluateOffer(
            source = OfferCaptureSource.OCR_SCREENSHOT,
            rawSnippet = "test",
            offerPriceBrl = 35.00,
            pickupAddress = "Centro, Montes Claros",
            customerAddress = "Rua Principal, 150 - Village do Lago",
            route = RouteCalculationResult(1.0, 4.5, 4.5, 10.0, "OSRM_REAL_ROADS"),
            usedGpsStart = true,
            neighborhoodRules = MontesClarosGeoCatalog.defaultRuleEntities(),
            settings = DriverSettings(minTargetPerKm = 1.90)
        )

        assertEquals(TrafficLightDecision.RED.name, result.decision)
        assertNotNull(result.neighborhoodAlert)
    }

    @Test
    fun `neighborhood detector supports Geocoder metadata, avenues, confidence levels, and never invents neighborhoods`() {
        val rules = MontesClarosGeoCatalog.defaultRuleEntities()

        val explicitMatch = MontesClarosGeoCatalog.identifyNeighborhood(
            address = "Rua Ibituruna, 120 - Centro, Montes Claros - MG, 39400-000",
            point = null,
            rules = rules
        )
        assertEquals("Centro", explicitMatch.name)
        assertEquals(NeighborhoodConfidence.HIGH, explicitMatch.confidence)

        val geocoderMatch = MontesClarosGeoCatalog.identifyNeighborhood(
            address = "Rua A, 100",
            point = GeoPoint(
                latitude = -16.7385,
                longitude = -43.8832,
                geocoderMetadata = GeocoderPlaceMetadata(subLocality = "Ibituruna")
            ),
            rules = rules
        )
        assertEquals("Ibituruna", geocoderMatch.name)
        assertEquals(NeighborhoodConfidence.HIGH, geocoderMatch.confidence)

        val landmarkMatch = MontesClarosGeoCatalog.identifyNeighborhood(
            address = "Portaria Principal - Unimontes, Montes Claros",
            point = null,
            rules = rules
        )
        assertEquals("Universitário", landmarkMatch.name)
        assertEquals(NeighborhoodConfidence.MEDIUM, landmarkMatch.confidence)

        val coordMatch = MontesClarosGeoCatalog.identifyNeighborhood(
            address = "Rua Sem Bairro No Texto, 500",
            point = GeoPoint(-16.6887, -43.8414),
            rules = rules
        )
        assertEquals("Village do Lago", coordMatch.name)
        assertEquals(NeighborhoodConfidence.MEDIUM, coordMatch.confidence)

        val unknownMatch = MontesClarosGeoCatalog.identifyNeighborhood(
            address = "Rua Desconhecida, 99 - Loja XYZ",
            point = null,
            rules = rules
        )
        assertEquals(MontesClarosGeoCatalog.UNIDENTIFIED_NEIGHBORHOOD, unknownMatch.name)
        assertEquals(NeighborhoodConfidence.UNIDENTIFIED, unknownMatch.confidence)
        assertNull(unknownMatch.rule)
    }

    @Test
    fun `route calculator caches OSRM results, isolates caller cancellation, and validates all 4 route points`() = runBlocking {
        val context = ApplicationProvider.getApplicationContext<Context>()
        val osrmCalls = AtomicInteger(0)
        val fakeOsrm = object : OsrmRoutingApi {
            override suspend fun getDrivingRoute(
                coordinates: String,
                overview: String,
                steps: String,
                alternatives: String,
                annotations: String
            ): OsrmRouteResponse {
                osrmCalls.incrementAndGet()
                delay(80)
                return OsrmRouteResponse(
                    code = "Ok",
                    routes = listOf(
                        OsrmRoute(
                            distance = 6200.0,
                            duration = 700.0,
                            legs = listOf(
                                OsrmLeg(1200.0, 140.0),
                                OsrmLeg(2600.0, 300.0),
                                OsrmLeg(2400.0, 260.0)
                            )
                        )
                    )
                )
            }
        }

        val calculator = RouteCalculator(
            context = context,
            cacheStore = InMemoryGeoCacheStore(),
            osrmApi = fakeOsrm,
            geocoderOverride = { null }
        )

        val start = GeoPoint(-16.7282, -43.8617, "Centro")

        val callerA = launch {
            calculator.calculateCompleteRoute(start, "Centro", "Ibituruna", true)
        }
        val callerB = async {
            calculator.calculateCompleteRoute(start, "Centro", "Ibituruna", true)
        }
        delay(20)
        callerA.cancelAndJoin()
        val resB = callerB.await()

        assertEquals(1, osrmCalls.get())
        assertTrue(resB is RouteResolutionResult.Resolved)
        assertEquals(RouteCalculator.ROUTE_SOURCE_OSRM, (resB as RouteResolutionResult.Resolved).route.routeSource)

        val cachedRes = calculator.calculateCompleteRoute(start, "Centro", "Ibituruna", true)
        assertEquals(1, osrmCalls.get())
        assertTrue(cachedRes is RouteResolutionResult.Resolved)
        val resolvedCached = (cachedRes as RouteResolutionResult.Resolved).route
        assertTrue(resolvedCached.fromCache)
        assertEquals(6.2, resolvedCached.totalKm, 0.01)

        val unknownRes = calculator.calculateCompleteRoute(
            start,
            "Centro",
            "Rua Totalmente Desconhecida XYZ 99999",
            true
        )
        assertTrue(unknownRes is RouteResolutionResult.UnresolvedAddress)
        assertFalse((unknownRes as RouteResolutionResult.UnresolvedAddress).missingPickup)
        assertTrue(unknownRes.missingCustomer)

        val invalidGpsRes = calculator.calculateCompleteRoute(
            GeoPoint(0.0, 0.0, "Invalid"),
            "Centro",
            "Ibituruna",
            true
        )
        assertTrue(invalidGpsRes is RouteResolutionResult.UnresolvedAddress)
    }

    @Test
    fun `service runtime bus isolates runs and blocks stale run overwrites`() {
        ServiceRuntimeBus.clearLatestOffer()
        val run1 = ServiceRuntimeBus.nextRunId()
        val run2 = ServiceRuntimeBus.nextRunId()

        ServiceRuntimeBus.beginRun(run2, "Analisando oferta mais recente")
        assertTrue(ServiceRuntimeBus.state.value.isAnalyzing)
        assertNull(ServiceRuntimeBus.state.value.latestOffer)

        val staleOffer = AnalyzedOfferEntity(
            id = 99,
            source = "ACCESSIBILITY",
            rawSnippet = "stale",
            offerPriceBrl = 10.0,
            pickupAddress = "Centro",
            pickupNeighborhood = "Centro",
            customerAddress = "Melo",
            customerNeighborhood = "Melo",
            leg1CurrentToPickupKm = 1.0,
            leg2PickupToCustomerKm = 2.0,
            leg3CustomerToCenterKm = 2.0,
            totalKm = 5.0,
            earningsPerKm = 2.0,
            targetPerKm = 1.9,
            decision = "GREEN",
            decisionReason = "stale",
            routeSource = "OSRM_REAL_ROADS",
            usedGpsStart = false
        )

        ServiceRuntimeBus.completeRun(run1, staleOffer, "com.moblets")
        assertNull(ServiceRuntimeBus.state.value.latestOffer)
        assertEquals(run2, ServiceRuntimeBus.state.value.activeRunId)
        assertFalse(ServiceRuntimeBus.isRunCurrent(run1))
        assertTrue(ServiceRuntimeBus.isRunCurrent(run2))
    }
}
EOF

cat << 'EOF' > app/src/test/java/com/example/DatabaseMigrationAndCacheRobolectricTest.kt
package com.example

import android.content.Context
import androidx.room.Room
import androidx.sqlite.db.SupportSQLiteDatabase
import androidx.sqlite.db.SupportSQLiteOpenHelper
import androidx.sqlite.db.framework.FrameworkSQLiteOpenHelperFactory
import androidx.test.core.app.ApplicationProvider
import com.example.data.OfferRepository
import com.example.data.RoomGeoCacheStore
import com.example.data.local.AnalyzedOfferEntity
import com.example.data.local.AppDatabase
import com.example.data.local.CachedAddressEntity
import com.example.data.local.CachedRouteEntity
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.runBlocking
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [36])
class DatabaseMigrationAndCacheRobolectricTest {

    private var db: AppDatabase? = null

    @After
    fun tearDown() {
        db?.close()
    }

    @Test
    fun `migration from v1 to v2 preserves existing offers and enables persistent Room cache`() = runBlocking {
        val context = ApplicationProvider.getApplicationContext<Context>()
        val dbName = "migration_test_${System.currentTimeMillis()}.db"
        context.deleteDatabase(dbName)

        val config = SupportSQLiteOpenHelper.Configuration.builder(context)
            .name(dbName)
            .callback(object : SupportSQLiteOpenHelper.Callback(1) {
                override fun onCreate(db: SupportSQLiteDatabase) {
                    db.execSQL(
                        """
                        CREATE TABLE IF NOT EXISTS `analyzed_offers` (
                            `id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                            `timestamp` INTEGER NOT NULL,
                            `source` TEXT NOT NULL,
                            `rawSnippet` TEXT NOT NULL,
                            `offerPriceBrl` REAL NOT NULL,
                            `pickupAddress` TEXT NOT NULL,
                            `pickupNeighborhood` TEXT NOT NULL,
                            `customerAddress` TEXT NOT NULL,
                            `customerNeighborhood` TEXT NOT NULL,
                            `leg1CurrentToPickupKm` REAL NOT NULL,
                            `leg2PickupToCustomerKm` REAL NOT NULL,
                            `leg3CustomerToCenterKm` REAL NOT NULL,
                            `totalKm` REAL NOT NULL,
                            `earningsPerKm` REAL NOT NULL,
                            `targetPerKm` REAL NOT NULL,
                            `decision` TEXT NOT NULL,
                            `decisionReason` TEXT NOT NULL,
                            `neighborhoodAlert` TEXT,
                            `routeSource` TEXT NOT NULL,
                            `usedGpsStart` INTEGER NOT NULL
                        )
                        """.trimIndent()
                    )
                    db.execSQL(
                        """
                        CREATE TABLE IF NOT EXISTS `neighborhood_rules` (
                            `name` TEXT NOT NULL,
                            `normalizedKey` TEXT NOT NULL,
                            `status` TEXT NOT NULL,
                            `notes` TEXT NOT NULL,
                            `isCustom` INTEGER NOT NULL,
                            `updatedAt` INTEGER NOT NULL,
                            PRIMARY KEY(`name`)
                        )
                        """.trimIndent()
                    )
                    db.execSQL(
                        """
                        INSERT INTO `analyzed_offers` (
                            `timestamp`, `source`, `rawSnippet`, `offerPriceBrl`,
                            `pickupAddress`, `pickupNeighborhood`, `customerAddress`, `customerNeighborhood`,
                            `leg1CurrentToPickupKm`, `leg2PickupToCustomerKm`, `leg3CustomerToCenterKm`,
                            `totalKm`, `earningsPerKm`, `targetPerKm`, `decision`, `decisionReason`,
                            `neighborhoodAlert`, `routeSource`, `usedGpsStart`
                        ) VALUES (
                            1700000000000, 'MANUAL', 'legacy', 20.0,
                            'Centro', 'Centro', 'Ibituruna', 'Ibituruna',
                            1.0, 3.0, 3.0, 7.0, 2.86, 1.9, 'GREEN', 'Legacy OK',
                            NULL, 'OSRM_REAL_ROADS', 1
                        )
                        """.trimIndent()
                    )
                }

                override fun onUpgrade(db: SupportSQLiteDatabase, oldVersion: Int, newVersion: Int) {}
            })
            .build()

        FrameworkSQLiteOpenHelperFactory().create(config).writableDatabase.close()

        val migratedDb = Room.databaseBuilder(context, AppDatabase::class.java, dbName)
            .addMigrations(AppDatabase.MIGRATION_1_2)
            .allowMainThreadQueries()
            .build()
        db = migratedDb

        val offersAfterMigration = migratedDb.offerDao().observeAllOffers().first()
        assertEquals(1, offersAfterMigration.size)
        assertEquals("Legacy OK", offersAfterMigration.first().decisionReason)

        val cacheStore = RoomGeoCacheStore(migratedDb.geoCacheDao())
        val now = 1_750_000_000_000L
        cacheStore.putAddress(
            CachedAddressEntity(
                normalizedQuery = "av esteves rodrigues 450 centro",
                originalQuery = "Av. Esteves Rodrigues, 450 - Centro",
                latitude = -16.7282,
                longitude = -43.8617,
                resolvedNeighborhood = "Centro",
                resolutionSource = "GEOCODER",
                createdAt = now,
                expiresAt = now + 60_000L
            )
        )
        assertNotNull(cacheStore.getValidAddress("av esteves rodrigues 450 centro", now + 10_000L))
        assertNull(cacheStore.getValidAddress("av esteves rodrigues 450 centro", now + 120_000L))

        cacheStore.putRoute(
            CachedRouteEntity(
                routeKey = "route_1",
                leg1Km = 1.2,
                leg2Km = 2.4,
                leg3Km = 2.5,
                totalKm = 6.1,
                routeSource = "OSRM_REAL_ROADS",
                createdAt = now,
                expiresAt = now + 60_000L
            )
        )
        assertNotNull(cacheStore.getValidRoute("route_1", now + 1_000L))
        assertNull(cacheStore.getValidRoute("route_1", now + 90_000L))

        assertEquals(1, migratedDb.geoCacheDao().countValidAddresses(now + 10_000L))
        cacheStore.pruneExpired(now + 120_000L)
        assertEquals(0, migratedDb.geoCacheDao().countValidAddresses(now + 120_000L))
        assertEquals(0, migratedDb.geoCacheDao().countValidRoutes(now + 120_000L))

        val repo = OfferRepository(migratedDb.offerDao(), migratedDb.neighborhoodDao())
        val freshOffer = AnalyzedOfferEntity(
            timestamp = System.currentTimeMillis(),
            source = "MANUAL",
            rawSnippet = "fresh",
            offerPriceBrl = 19.0,
            pickupAddress = "Centro",
            pickupNeighborhood = "Centro",
            customerAddress = "Ibituruna",
            customerNeighborhood = "Ibituruna",
            leg1CurrentToPickupKm = 1.0,
            leg2PickupToCustomerKm = 3.0,
            leg3CustomerToCenterKm = 3.0,
            totalKm = 7.0,
            earningsPerKm = 2.71,
            targetPerKm = 1.9,
            decision = "GREEN",
            decisionReason = "Fresh OK",
            routeSource = "OSRM_REAL_ROADS",
            usedGpsStart = true
        )
        repo.saveAnalyzedOffer(freshOffer)
        val remaining = migratedDb.offerDao().observeAllOffers().first()
        assertEquals(1, remaining.size)
        assertEquals("Fresh OK", remaining.first().decisionReason)
    }
}
EOF

if [ ! -f debug.keystore ]; then
  if command -v keytool >/dev/null 2>&1; then
    keytool -genkeypair -v \
      -keystore debug.keystore \
      -alias androiddebugkey \
      -keyalg RSA \
      -keysize 2048 \
      -validity 10000 \
      -storepass android \
      -keypass android \
      -dname "CN=Android Debug,O=Android,C=US"
  else
    echo "AVISO: keytool não encontrado no ambiente; gere debug.keystore antes do assembleDebug."
  fi
fi

echo ""
echo "================================================================"
echo "Projeto Rota Inteligente IA criado em: $(pwd)"
echo "Pacote / ApplicationId: com.aistudio.rotainteligente.mocvkw"
echo "Próximos passos no Termux:"
echo "  1) cd $PROJECT_DIR"
echo "  2) gradle :app:testDebugUnitTest :app:assembleDebug"
echo "  3) APK Debug assinado: app/build/outputs/apk/debug/app-debug.apk"
echo "================================================================"
