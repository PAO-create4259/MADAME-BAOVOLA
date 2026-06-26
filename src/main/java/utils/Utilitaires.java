package utils;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

public class Utilitaires {

    // On crée une méthode statique pour pouvoir l'appeler partout sans instancier la classe
    public static String formaterNombre(double nombre) {
        // On utilise les standards français (qui correspondent à Madagascar pour l'espace des milliers)
        DecimalFormatSymbols symboles = new DecimalFormatSymbols(Locale.FRENCH);
        symboles.setGroupingSeparator(' ');

        DecimalFormat formatteur = new DecimalFormat("###,###.##", symboles);
        return formatteur.format(nombre);
    }
}