// Autogenerated from Pigeon (v22.4.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
@file:Suppress("UNCHECKED_CAST", "ArrayInDataClass")


import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  return if (exception is FlutterError) {
    listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

private fun createConnectionError(channelName: String): FlutterError {
  return FlutterError("channel-error",  "Unable to establish connection on channel: '$channelName'.", "")}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

/** Influences the y direction of the tile coordinates. */
enum class TileScheme(val raw: Int) {
  /** Slippy map tilenames scheme. */
  XYZ(0),
  /** OSGeo spec scheme. */
  TMS(1);

  companion object {
    fun ofRaw(raw: Int): TileScheme? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** The encoding used by this source. Mapbox Terrain RGB is used by default. */
enum class RasterDemEncoding(val raw: Int) {
  /** Terrarium format PNG tiles. */
  TERRARIUM(0),
  /** Mapbox Terrain RGB tiles. */
  MAPBOX(1),
  /**
   * Decodes tiles using the redFactor, blueFactor, greenFactor, baseShift
   * parameters.
   */
  CUSTOM(2);

  companion object {
    fun ofRaw(raw: Int): RasterDemEncoding? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** The reason the camera is changing. */
enum class CameraChangeReason(val raw: Int) {
  /** Developer animation. */
  DEVELOPER_ANIMATION(0),
  /** API animation. */
  API_ANIMATION(1),
  /** API gesture */
  API_GESTURE(2);

  companion object {
    fun ofRaw(raw: Int): CameraChangeReason? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/**
 * The map options define initial values for the MapLibre map.
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class MapOptions (
  /** The URL of the used map style. */
  val style: String,
  /** The initial zoom level of the map. */
  val zoom: Double,
  /** The initial pitch / tilt of the map. */
  val pitch: Double,
  /** The initial bearing of the map. */
  val bearing: Double,
  /** The initial center coordinates of the map. */
  val center: LngLat? = null,
  /** The maximum bounding box of the map camera. */
  val maxBounds: LngLatBounds? = null,
  /** The minimum zoom level of the map. */
  val minZoom: Double,
  /** The maximum zoom level of the map. */
  val maxZoom: Double,
  /** The minimum pitch / tilt of the map. */
  val minPitch: Double,
  /** The maximum pitch / tilt of the map. */
  val maxPitch: Double,
  /** The map gestures. */
  val gestures: MapGestures
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): MapOptions {
      val style = pigeonVar_list[0] as String
      val zoom = pigeonVar_list[1] as Double
      val pitch = pigeonVar_list[2] as Double
      val bearing = pigeonVar_list[3] as Double
      val center = pigeonVar_list[4] as LngLat?
      val maxBounds = pigeonVar_list[5] as LngLatBounds?
      val minZoom = pigeonVar_list[6] as Double
      val maxZoom = pigeonVar_list[7] as Double
      val minPitch = pigeonVar_list[8] as Double
      val maxPitch = pigeonVar_list[9] as Double
      val gestures = pigeonVar_list[10] as MapGestures
      return MapOptions(style, zoom, pitch, bearing, center, maxBounds, minZoom, maxZoom, minPitch, maxPitch, gestures)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      style,
      zoom,
      pitch,
      bearing,
      center,
      maxBounds,
      minZoom,
      maxZoom,
      minPitch,
      maxPitch,
      gestures,
    )
  }
}

/**
 * Map gestures
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class MapGestures (
  /** Rotate the map bearing. */
  val rotate: Boolean,
  /** Move the center of the map around. */
  val pan: Boolean,
  /** Zoom the map in and out. */
  val zoom: Boolean,
  /** Tilt (pitch) the map camera. */
  val tilt: Boolean
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): MapGestures {
      val rotate = pigeonVar_list[0] as Boolean
      val pan = pigeonVar_list[1] as Boolean
      val zoom = pigeonVar_list[2] as Boolean
      val tilt = pigeonVar_list[3] as Boolean
      return MapGestures(rotate, pan, zoom, tilt)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      rotate,
      pan,
      zoom,
      tilt,
    )
  }
}

/**
 * A longitude/latitude coordinate object.
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class LngLat (
  /** The longitude */
  val lng: Double,
  /** The latitude */
  val lat: Double
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): LngLat {
      val lng = pigeonVar_list[0] as Double
      val lat = pigeonVar_list[1] as Double
      return LngLat(lng, lat)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      lng,
      lat,
    )
  }
}

/**
 * A pixel location / location on the device screen.
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class Offset (
  /** The x coordinate */
  val x: Double,
  /** The y coordinate */
  val y: Double
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): Offset {
      val x = pigeonVar_list[0] as Double
      val y = pigeonVar_list[1] as Double
      return Offset(x, y)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      x,
      y,
    )
  }
}

/**
 * Camera Padding
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class Padding (
  val top: Long,
  val bottom: Long,
  val left: Long,
  val right: Long
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): Padding {
      val top = pigeonVar_list[0] as Long
      val bottom = pigeonVar_list[1] as Long
      val left = pigeonVar_list[2] as Long
      val right = pigeonVar_list[3] as Long
      return Padding(top, bottom, left, right)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      top,
      bottom,
      left,
      right,
    )
  }
}

/**
 * The current position of the map camera.
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class MapCamera (
  val center: LngLat,
  val zoom: Double,
  val pitch: Double,
  val bearing: Double
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): MapCamera {
      val center = pigeonVar_list[0] as LngLat
      val zoom = pigeonVar_list[1] as Double
      val pitch = pigeonVar_list[2] as Double
      val bearing = pigeonVar_list[3] as Double
      return MapCamera(center, zoom, pitch, bearing)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      center,
      zoom,
      pitch,
      bearing,
    )
  }
}

/**
 * LatLng bound object
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class LngLatBounds (
  val longitudeWest: Double,
  val longitudeEast: Double,
  val latitudeSouth: Double,
  val latitudeNorth: Double
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): LngLatBounds {
      val longitudeWest = pigeonVar_list[0] as Double
      val longitudeEast = pigeonVar_list[1] as Double
      val latitudeSouth = pigeonVar_list[2] as Double
      val latitudeNorth = pigeonVar_list[3] as Double
      return LngLatBounds(longitudeWest, longitudeEast, latitudeSouth, latitudeNorth)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      longitudeWest,
      longitudeEast,
      latitudeSouth,
      latitudeNorth,
    )
  }
}
private open class PigeonPigeonCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      129.toByte() -> {
        return (readValue(buffer) as Long?)?.let {
          TileScheme.ofRaw(it.toInt())
        }
      }
      130.toByte() -> {
        return (readValue(buffer) as Long?)?.let {
          RasterDemEncoding.ofRaw(it.toInt())
        }
      }
      131.toByte() -> {
        return (readValue(buffer) as Long?)?.let {
          CameraChangeReason.ofRaw(it.toInt())
        }
      }
      132.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MapOptions.fromList(it)
        }
      }
      133.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MapGestures.fromList(it)
        }
      }
      134.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          LngLat.fromList(it)
        }
      }
      135.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          Offset.fromList(it)
        }
      }
      136.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          Padding.fromList(it)
        }
      }
      137.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MapCamera.fromList(it)
        }
      }
      138.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          LngLatBounds.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is TileScheme -> {
        stream.write(129)
        writeValue(stream, value.raw)
      }
      is RasterDemEncoding -> {
        stream.write(130)
        writeValue(stream, value.raw)
      }
      is CameraChangeReason -> {
        stream.write(131)
        writeValue(stream, value.raw)
      }
      is MapOptions -> {
        stream.write(132)
        writeValue(stream, value.toList())
      }
      is MapGestures -> {
        stream.write(133)
        writeValue(stream, value.toList())
      }
      is LngLat -> {
        stream.write(134)
        writeValue(stream, value.toList())
      }
      is Offset -> {
        stream.write(135)
        writeValue(stream, value.toList())
      }
      is Padding -> {
        stream.write(136)
        writeValue(stream, value.toList())
      }
      is MapCamera -> {
        stream.write(137)
        writeValue(stream, value.toList())
      }
      is LngLatBounds -> {
        stream.write(138)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}


/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface MapLibreHostApi {
  /** Add a fill layer to the map style. */
  fun addFillLayer(id: String, sourceId: String, layout: Map<String, Any>, paint: Map<String, Any>, belowLayerId: String?, callback: (Result<Unit>) -> Unit)
  /** Add a circle layer to the map style. */
  fun addCircleLayer(id: String, sourceId: String, layout: Map<String, Any>, paint: Map<String, Any>, belowLayerId: String?, callback: (Result<Unit>) -> Unit)
  /** Add a background layer to the map style. */
  fun addBackgroundLayer(id: String, layout: Map<String, Any>, paint: Map<String, Any>, belowLayerId: String?, callback: (Result<Unit>) -> Unit)
  /** Add a fill extrusion layer to the map style. */
  fun addFillExtrusionLayer(id: String, sourceId: String, layout: Map<String, Any>, paint: Map<String, Any>, belowLayerId: String?, callback: (Result<Unit>) -> Unit)
  /** Add a heatmap layer to the map style. */
  fun addHeatmapLayer(id: String, sourceId: String, layout: Map<String, Any>, paint: Map<String, Any>, belowLayerId: String?, callback: (Result<Unit>) -> Unit)
  /** Add a hillshade layer to the map style. */
  fun addHillshadeLayer(id: String, sourceId: String, layout: Map<String, Any>, paint: Map<String, Any>, belowLayerId: String?, callback: (Result<Unit>) -> Unit)
  /** Add a line layer to the map style. */
  fun addLineLayer(id: String, sourceId: String, layout: Map<String, Any>, paint: Map<String, Any>, belowLayerId: String?, callback: (Result<Unit>) -> Unit)
  /** Add a raster layer to the map style. */
  fun addRasterLayer(id: String, sourceId: String, layout: Map<String, Any>, paint: Map<String, Any>, belowLayerId: String?, callback: (Result<Unit>) -> Unit)
  /** Add a symbol layer to the map style. */
  fun addSymbolLayer(id: String, sourceId: String, layout: Map<String, Any>, paint: Map<String, Any>, belowLayerId: String?, callback: (Result<Unit>) -> Unit)
  /**
   * Loads an image to the map. An image needs to be loaded before it can
   * get used.
   */
  fun loadImage(url: String, callback: (Result<ByteArray>) -> Unit)
  /** Add an image to the map. */
  fun addImage(id: String, bytes: ByteArray, callback: (Result<Unit>) -> Unit)

  companion object {
    /** The codec used by MapLibreHostApi. */
    val codec: MessageCodec<Any?> by lazy {
      PigeonPigeonCodec()
    }
    /** Sets up an instance of `MapLibreHostApi` to handle messages through the `binaryMessenger`. */
    @JvmOverloads
    fun setUp(binaryMessenger: BinaryMessenger, api: MapLibreHostApi?, messageChannelSuffix: String = "") {
      val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.maplibre.MapLibreHostApi.addFillLayer$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val idArg = args[0] as String
            val sourceIdArg = args[1] as String
            val layoutArg = args[2] as Map<String, Any>
            val paintArg = args[3] as Map<String, Any>
            val belowLayerIdArg = args[4] as String?
            api.addFillLayer(idArg, sourceIdArg, layoutArg, paintArg, belowLayerIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.maplibre.MapLibreHostApi.addCircleLayer$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val idArg = args[0] as String
            val sourceIdArg = args[1] as String
            val layoutArg = args[2] as Map<String, Any>
            val paintArg = args[3] as Map<String, Any>
            val belowLayerIdArg = args[4] as String?
            api.addCircleLayer(idArg, sourceIdArg, layoutArg, paintArg, belowLayerIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.maplibre.MapLibreHostApi.addBackgroundLayer$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val idArg = args[0] as String
            val layoutArg = args[1] as Map<String, Any>
            val paintArg = args[2] as Map<String, Any>
            val belowLayerIdArg = args[3] as String?
            api.addBackgroundLayer(idArg, layoutArg, paintArg, belowLayerIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.maplibre.MapLibreHostApi.addFillExtrusionLayer$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val idArg = args[0] as String
            val sourceIdArg = args[1] as String
            val layoutArg = args[2] as Map<String, Any>
            val paintArg = args[3] as Map<String, Any>
            val belowLayerIdArg = args[4] as String?
            api.addFillExtrusionLayer(idArg, sourceIdArg, layoutArg, paintArg, belowLayerIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.maplibre.MapLibreHostApi.addHeatmapLayer$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val idArg = args[0] as String
            val sourceIdArg = args[1] as String
            val layoutArg = args[2] as Map<String, Any>
            val paintArg = args[3] as Map<String, Any>
            val belowLayerIdArg = args[4] as String?
            api.addHeatmapLayer(idArg, sourceIdArg, layoutArg, paintArg, belowLayerIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.maplibre.MapLibreHostApi.addHillshadeLayer$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val idArg = args[0] as String
            val sourceIdArg = args[1] as String
            val layoutArg = args[2] as Map<String, Any>
            val paintArg = args[3] as Map<String, Any>
            val belowLayerIdArg = args[4] as String?
            api.addHillshadeLayer(idArg, sourceIdArg, layoutArg, paintArg, belowLayerIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.maplibre.MapLibreHostApi.addLineLayer$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val idArg = args[0] as String
            val sourceIdArg = args[1] as String
            val layoutArg = args[2] as Map<String, Any>
            val paintArg = args[3] as Map<String, Any>
            val belowLayerIdArg = args[4] as String?
            api.addLineLayer(idArg, sourceIdArg, layoutArg, paintArg, belowLayerIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.maplibre.MapLibreHostApi.addRasterLayer$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val idArg = args[0] as String
            val sourceIdArg = args[1] as String
            val layoutArg = args[2] as Map<String, Any>
            val paintArg = args[3] as Map<String, Any>
            val belowLayerIdArg = args[4] as String?
            api.addRasterLayer(idArg, sourceIdArg, layoutArg, paintArg, belowLayerIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.maplibre.MapLibreHostApi.addSymbolLayer$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val idArg = args[0] as String
            val sourceIdArg = args[1] as String
            val layoutArg = args[2] as Map<String, Any>
            val paintArg = args[3] as Map<String, Any>
            val belowLayerIdArg = args[4] as String?
            api.addSymbolLayer(idArg, sourceIdArg, layoutArg, paintArg, belowLayerIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.maplibre.MapLibreHostApi.loadImage$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val urlArg = args[0] as String
            api.loadImage(urlArg) { result: Result<ByteArray> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.maplibre.MapLibreHostApi.addImage$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val idArg = args[0] as String
            val bytesArg = args[1] as ByteArray
            api.addImage(idArg, bytesArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
class MapLibreFlutterApi(private val binaryMessenger: BinaryMessenger, private val messageChannelSuffix: String = "") {
  companion object {
    /** The codec used by MapLibreFlutterApi. */
    val codec: MessageCodec<Any?> by lazy {
      PigeonPigeonCodec()
    }
  }
  /** Get the map options from dart. */
  fun getOptions(callback: (Result<MapOptions>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.maplibre.MapLibreFlutterApi.getOptions$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(null) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else if (it[0] == null) {
          callback(Result.failure(FlutterError("null-error", "Flutter api returned null value for non-null return value.", "")))
        } else {
          val output = it[0] as MapOptions
          callback(Result.success(output))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  /** Callback for when the style has been loaded. */
  fun onStyleLoaded(callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onStyleLoaded$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(null) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  /** Callback for when the map is ready and can be used. */
  fun onMapReady(callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onMapReady$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(null) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  /** Callback when the user clicks on the map. */
  fun onClick(pointArg: LngLat, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onClick$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(pointArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  /** Callback when the map idles. */
  fun onIdle(callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onIdle$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(null) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  /** Callback when the map camera idles. */
  fun onCameraIdle(callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onCameraIdle$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(null) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  /**
   * Callback when the user performs a secondary click on the map
   * (e.g. by default a click with the right mouse button).
   */
  fun onSecondaryClick(pointArg: LngLat, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onSecondaryClick$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(pointArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  /** Callback when the user performs a double click on the map. */
  fun onDoubleClick(pointArg: LngLat, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onDoubleClick$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(pointArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  /** Callback when the user performs a long lasting click on the map. */
  fun onLongClick(pointArg: LngLat, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onLongClick$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(pointArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  /** Callback when the map camera changes. */
  fun onMoveCamera(cameraArg: MapCamera, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onMoveCamera$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(cameraArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  /** Callback when the map camera starts changing. */
  fun onStartMoveCamera(reasonArg: CameraChangeReason, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.maplibre.MapLibreFlutterApi.onStartMoveCamera$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(reasonArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
}
