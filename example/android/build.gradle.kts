allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

apply plugin : "org.jlleitschuh.gradle.ktlint"

ktlint {
    version = "0.43.2"
    android = true
    ignoreFailures = false
    reporters {
        reporter("plain")
        reporter("checkstyle")
    }
    dependencies {
        // noinspection GradleDynamicVersion
        ktlintRuleset("io.nlopez.compose.rules:ktlint:0.4.+")
    }
    filter {
        exclude("**/*.g.kt")
    }
}