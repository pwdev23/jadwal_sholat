package pw.projectweekend.jadwal_sholat

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * Implementation of App Widget functionality.
 */
class TimingsWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            // Get reference to SharedPreferences
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.timings_widget).apply {

                val txtImsak = widgetData.getString("txtImsak", null)
                setTextViewText(R.id.txtImsak, txtImsak ?: "n/a")

                val txtFajr = widgetData.getString("txtFajr", null)
                setTextViewText(R.id.txtFajr, txtFajr ?: "n/a")

                val txtSunrise = widgetData.getString("txtSunrise", null)
                setTextViewText(R.id.txtSunrise, txtSunrise ?: "n/a")

                val txtDhuhr = widgetData.getString("txtDhuhr", null)
                setTextViewText(R.id.txtDhuhr, txtDhuhr ?: "n/a")

                val txtAsr = widgetData.getString("txtAsr", null)
                setTextViewText(R.id.txtAsr, txtAsr ?: "n/a")

                val txtMaghrib = widgetData.getString("txtMaghrib", null)
                setTextViewText(R.id.txtMaghrib, txtMaghrib ?: "n/a")

                val txtIsha = widgetData.getString("txtIsha", null)
                setTextViewText(R.id.txtIsha, txtIsha ?: "n/a")
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}