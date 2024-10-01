package com.github.josxha.maplibre;

import androidx.annotation.Keep;

import org.maplibre.android.maps.MapLibreMap;

import java.util.HashMap;

@Keep
public class MapLibreMapRegistry {
    private static final HashMap<Integer, MapLibreMap> registry = new HashMap<>();

    @Keep
    public static MapLibreMap get(int viewId) {
        return registry.get(viewId);
    }

    public static void add(int viewId,  MapLibreMap map) {
        registry.put(viewId, map);
    }
}
