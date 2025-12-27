package com.github.josxha.maplibre

import android.annotation.SuppressLint
import androidx.annotation.Keep
import org.maplibre.android.style.expressions.Expression

@Keep
@SuppressLint("StaticFieldLeak")
object Helpers {
    /**
     * Parses a raw expression string into an Expression object.
     * https://github.com/dart-lang/native/issues/2903
     */
    public fun parseExpression(raw: String): Expression {
        return Expression.Converter.convert(raw)
    }
}
