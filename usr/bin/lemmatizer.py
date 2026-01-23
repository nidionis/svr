#!/usr/bin/env python3
import sys
import spacy

# Charger les modèles français et anglais
nlp_fr = spacy.load("fr_core_news_sm")
nlp_en = spacy.load("en_core_web_sm")

# Lire le texte depuis stdin
text = sys.stdin.read().strip()

# Détecter la langue (simple : regarder les caractères ou demander en argument)
# Ici, on choisit automatiquement en fonction des mots
# -> si beaucoup de mots anglais, on prend anglais, sinon français
words = text.split()
english_words = sum(1 for w in words if w.lower() in ["the","is","are","i","you","we","and"])
nlp = nlp_en if english_words > len(words) / 2 else nlp_fr

# Lemmatiser
doc = nlp(text)
lemmes = [token.lemma_ for token in doc if token.is_alpha]

print(" ".join(lemmes))




