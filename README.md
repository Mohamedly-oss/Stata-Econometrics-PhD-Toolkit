# Stata-Econometrics-PhD-Toolkit
Workflow Stata complet pour la recherche en économie : du nettoyage de données d'enquêtes à l'évaluation d'impact. Inclut régressions OLS/Logit , diagnostics avancés , graphiques de niveau publication et simulations de Monte Carlo. Optimisé pour l'analyse de données agricoles et climatiques

# 📊 Stata Econometrics PhD Toolkit

> **Workflow Stata complet pour la recherche en économie appliquée** — du nettoyage de données d'enquêtes à l'évaluation d'impact. Optimisé pour l'analyse de données agricoles et climatiques dans les pays en développement.

---

## 🗂️ Structure du projet

```
Stata-Econometrics-PhD-Toolkit/
├── 01_Data_Cleaning_and_Management.do       # Nettoyage et gestion des données
├── 02_Exploratory_Data_Analysis.do          # Analyse exploratoire
├── 03_Data_Visualization_Professional.do   # Graphiques niveau publication
├── 04_Linear_Models_and_Diagnostics.do     # Modèles linéaires et diagnostics
├── 05_NonLinear_and_Impact_Evaluation.do   # Modèles non-linéaires et évaluation d'impact
└── README.md
```

---

## 🔍 Contenu des modules

### `01` — Nettoyage et gestion des données
- Importation et fusion de bases de données d'enquêtes (ménages, agriculteurs)
- Traitement des valeurs manquantes, doublons et outliers
- Recodage et labellisation des variables
- Construction d'identifiants uniques et de panels

### `02` — Analyse exploratoire (EDA)
- Statistiques descriptives détaillées
- Distributions, percentiles et tableaux de fréquences
- Analyse de corrélations et matrices de covariance
- Tests de normalité et d'équilibre entre groupes

### `03` — Visualisation professionnelle
- Graphiques prêts pour publication (histogrammes, scatter plots, box plots)
- Courbes de densité kernel et quantile plots
- Cartes de chaleur et matrices de corrélation
- Mise en forme conforme aux standards des revues économiques

### `04` — Modèles linéaires et diagnostics
- Régressions OLS simples, multiples et robustes
- Tests d'hétéroscédasticité (Breusch-Pagan, White)
- Tests de multicolinéarité (VIF) et de spécification (Ramsey RESET)
- Régressions avec effets fixes et erreurs standard clusterisées

### `05` — Modèles non-linéaires et évaluation d'impact
- Modèles Logit, Probit et Tobit
- Score de propension (Propensity Score Matching — PSM)
- Variables instrumentales (IV / 2SLS)
- Différences en différences (DiD)
- Simulations de Monte Carlo

---

## ⚙️ Prérequis

- **Stata** 15 ou supérieur (certains modules nécessitent Stata 16+)
- Packages externes recommandés :
  - `estout` / `esttab` — export de tableaux de régression
  - `coefplot` — visualisation des coefficients
  - `psmatch2` — Propensity Score Matching
  - `ivreg2` — variables instrumentales avancées
  - `outreg2` — export vers Word/LaTeX

Installation rapide des packages :
```stata
ssc install estout
ssc install coefplot
ssc install psmatch2
ssc install ivreg2
ssc install outreg2
```

---

## 🚀 Utilisation

Cloner le dépôt ou télécharger les fichiers `.do`, puis les exécuter dans l'ordre numérique :

```stata
* Exécuter depuis Stata
do "01_Data_Cleaning_and_Management.do"
do "02_Exploratory_Data_Analysis.do"
do "03_Data_Visualization_Professional.do"
do "04_Linear_Models_and_Diagnostics.do"
do "05_NonLinear_and_Impact_Evaluation.do"
```

> 💡 **Conseil** : Adapte les chemins d'accès (`global path`) et les noms de variables à ta propre base de données au début de chaque fichier.

---

## 🌾 Domaines d'application

Ce toolkit est particulièrement adapté pour :

- Analyse de données d'enquêtes agricoles (LSMS, EHCVM, AGVSAN)
- Études sur l'adoption de technologies agricoles
- Évaluation d'impact de programmes agro-climatiques
- Recherche sur la sécurité alimentaire et les chocs climatiques
- Économétrie du développement (Afrique subsaharienne, Sahel)

---

## 📚 Références méthodologiques

- Wooldridge, J.M. (2010). *Econometric Analysis of Cross Section and Panel Data*
- Angrist, J.D. & Pischke, J.-S. (2009). *Mostly Harmless Econometrics*
- Cameron, A.C. & Trivedi, P.K. (2005). *Microeconometrics: Methods and Applications*
- StataCorp. *Stata Statistical Software*, College Station, TX

---

## 👤 Auteur

**Mohamedly-oss**
Chercheur en économie appliquée | Économétrie du développement

---

## 📄 Licence

Ce projet est distribué en libre accès à des fins académiques et de recherche.  
N'hésitez pas à adapter, forker et contribuer.

---

> *"Good data work is invisible. Good econometrics makes the invisible visible."*
