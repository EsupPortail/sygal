//fonction affichant ou non les div en fonction de boutons radios
function showOrNotDiv(radiobutton, additionnalFields, ifItsAtLoadingPage) {
    radiobutton.forEach(function (radio) {
        radio.addEventListener('change', function () {
            if (radio.checked && radio.value === "1") {
                additionnalFields.style.display = 'block';
            } else {
                additionnalFields.style.display = 'none';
            }
        });

        if (ifItsAtLoadingPage && radio.checked && radio.value === "1") {
            additionnalFields.style.display = 'block';
        }
    });
}
const currentUrl = window.location.href;
document.addEventListener("DOMContentLoaded", function() {
    //permet de afficher/cacher le textarea observations pour le gestionnaire
    const commentairesDiv = document.querySelector(".commentaires_gestionnaire");
    const radioButtons = document.querySelectorAll('.observations_gestionnaire .multicheckbox input[type="radio"]');

    radioButtons.forEach(radioButton => {
        radioButton.addEventListener('click', function () {
            if (this.classList.contains('incomplet')) {
                commentairesDiv.style.display = 'block';
            } else if (this.classList.contains('complet')) {
                commentairesDiv.style.display = 'none';
            }

            document.querySelectorAll('.multicheckbox label').forEach(label => {
                label.classList.remove('selected');
            });

            const label = this.parentElement;
            label.classList.add('selected');
        });

        // Sélectionnez le label parent et ajoutez la classe "selected"
        const label = radioButton.parentElement;
        if (radioButton.checked) {
            label.classList.add('selected');
        }
        if(radioButton.classList.contains('complet') && label.classList.contains('selected') || radioButton.classList.contains('incomplet') && !radioButton.checked){
            commentairesDiv.style.display = "none";
        }
    });
});


setTimeout(function () {
    if (currentUrl.indexOf("/etudiant") !== -1) {
        //désactive la possibilité de changer la civilité
        if(readOnly){
            $('input:radio[name="etudiant[niveauEtude]"]:not(:checked)').attr('disabled', true);
            $('input:radio[name="etudiant[situationHandicap]"]:not(:checked)').attr('disabled', true);
            $('input:radio[name="etudiant[typeDiplomeAutre]"]:not(:checked)').attr('disabled', true);
            $('select[name="etudiant[anneeDobtentionDiplomeAutre]"]').attr('disabled', true);
            $('select[name="etudiant[anneeDobtentionDiplomeNational]"]').attr('disabled', true);
        }
        $('input:radio[name="etudiant[civilite]"]:not(:checked)').attr('disabled', true);
        const diplomeRadios = document.querySelectorAll('input[name="etudiant[niveauEtude]"]');
        const additionalFieldsDiplome = document.getElementById('additional_fields_diplome');
        const additionalFieldsAutre = document.getElementById('additional_fields_autre');

        additionalFieldsDiplome.style.display = 'none';
        additionalFieldsAutre.style.display = 'none';

        diplomeRadios.forEach(function (radio) {
            radio.addEventListener('change', function () {
                if (radio.checked && radio.value === "1") {
                    additionalFieldsDiplome.style.display = 'block';
                    additionalFieldsAutre.style.display = 'none';
                } else {
                    additionalFieldsDiplome.style.display = 'none';
                    additionalFieldsAutre.style.display = 'block';
                }
            });
        });

        document.addEventListener('DOMContentLoaded', function () {
            diplomeRadios.forEach(function (radio) {
                if (radio.checked && radio.value === "1") {
                    additionalFieldsDiplome.style.display = 'block';
                    additionalFieldsAutre.style.display = 'none';
                }
                if (radio.checked && radio.value === "2") {
                    additionalFieldsDiplome.style.display = 'none';
                    additionalFieldsAutre.style.display = 'block';
                }
            });
        })
    }

    if (currentUrl.indexOf("/inscription") !== -1) {
        if(readOnly){
            $('input:radio[name="inscription[confidentialite]"]:not(:checked)').attr('disabled', true);
            $('input:radio[name="inscription[coTutelle]"]:not(:checked)').attr('disabled', true);
            $('input:radio[name="inscription[coDirection]"]:not(:checked)').attr('disabled', true);
            $('input:radio[name="inscription[coEncadrement]"]:not(:checked)').attr('disabled', true);
            $('select[name="inscription[ecoleDoctorale]"]').attr('disabled', true);
            $('select[name="inscription[specialiteDoctorat]"]').attr('disabled', true);
            $('select[name="inscription[uniteRecherche]"]').attr('disabled', true);
        }

        const confidentialiteRadios = document.querySelectorAll('input[name="inscription[confidentialite]"]');
        const cotutelleRadios = document.querySelectorAll('input[name="inscription[coTutelle]"]');
        const codirectionRadios = document.querySelectorAll('input[name="inscription[coDirection]"]');
        const additionalFieldsConfidentialite = document.getElementById('additionalFieldsConfidentialite');
        const additionalFieldsCotutelle = document.getElementById('additionalFieldsCotutelle');
        const additionalFieldsCodirection = document.getElementById('additionalFieldsCodirection');

        document.addEventListener('DOMContentLoaded', function () {
            additionalFieldsConfidentialite.style.display = 'none';
            additionalFieldsCotutelle.style.display = 'none';
            additionalFieldsCodirection.style.display = 'none';
            showOrNotDiv(confidentialiteRadios, additionalFieldsConfidentialite, true)
            showOrNotDiv(cotutelleRadios, additionalFieldsCotutelle, true)
            showOrNotDiv(codirectionRadios, additionalFieldsCodirection, true)
        })

        showOrNotDiv(confidentialiteRadios, additionalFieldsConfidentialite, false)
        showOrNotDiv(cotutelleRadios, additionalFieldsCotutelle, false)
        showOrNotDiv(codirectionRadios, additionalFieldsCodirection, false)
    }

    if (currentUrl.indexOf("/financement") !== -1) {
        if(readOnly){
            $('input:radio[name="financement[contratDoctoral]"]:not(:checked)').attr('disabled', true);
            $('input:radio[name="financement[employeurContrat]"]:not(:checked)').attr('disabled', true);
        }
        const contratDoctoralRadios = document.querySelectorAll('input[name="financement[contratDoctoral]"]');
        const additionalFieldscontratDoctoral = document.getElementById('additional_fields_contrat_doctoral');

        additionalFieldscontratDoctoral.style.display = 'none';

        document.addEventListener('DOMContentLoaded', function () {
            showOrNotDiv(contratDoctoralRadios, additionalFieldscontratDoctoral, true)
        })

        showOrNotDiv(contratDoctoralRadios, additionalFieldscontratDoctoral, false)
    }

    if (currentUrl.indexOf("/document") !== -1) {
        $(document).ready(function () {
            FilePond.registerPlugin(FilePondPluginFileValidateType);

            let serverResponse = '';
            // Sélectionner tous les champs de fichier et les transformer en champs FilePond
            $('input[type="file"]').each(function () {
                const inputId = $(this).attr('id');
                const pond = FilePond.create(this, {
                    acceptedFileTypes: ['application/pdf', 'image/png', 'image/jpeg'],
                    server: {
                        url: '/admission',
                        process: {
                            url: '/enregistrer-document/'+ individuId + '/' + inputId,
                            // ondata: (formData) => {
                            //     formData.append('individu', individuId);
                            //     formData.append('codeNatureFichier', inputId);
                            //     return formData;
                            // },
                            onerror: (response) =>
                                serverResponse = JSON.parse(response),
                        },
                        revert: {
                            url: '/supprimer-document/'+ individuId + '/' + inputId,
                            onerror: (response) =>
                                serverResponse = JSON.parse(response),
                        },
                        load: {
                            url: '/telecharger-document/'+ individuId + '/' + inputId +'?name=',
                        },
                        remove: (source, load, error) => {
                            fetch('/admission/supprimer-document/'+ individuId + '/' + inputId, {
                                method: 'DELETE',
                            }).then(response => {
                                if (!response.ok) {
                                    error("Erreur de suppression")
                                    throw new Error("Erreur de suppression");
                                }
                                load();
                                const admissionFileDiv = document.getElementById(inputId);
                                if (admissionFileDiv) {
                                    const uploadFileDiv = admissionFileDiv.parentElement;
                                    if (uploadFileDiv) {
                                        const dateTeleversementDiv = uploadFileDiv.nextElementSibling;
                                        const actionFileDiv = dateTeleversementDiv.nextElementSibling;
                                        if (dateTeleversementDiv && actionFileDiv) {
                                            dateTeleversementDiv.style.display = 'none';
                                            actionFileDiv.style.display = 'none';
                                        }
                                    }
                                }
                            }).catch(error => {
                                console.log(error)
                            });
                        }
                    },
                    beforeRemoveFile: function () { return confirm("Êtes-vous sûr de vouloir supprimer ce fichier ?"); },
                    labelFileProcessingError: () => {
                        return serverResponse.errors;
                    },
                    labelFileProcessingRevertError: () => {
                        return serverResponse.errors;
                    },
                    labelFileRemoveError: () => {
                        return serverResponse.errors;
                    },
                    labelFileLoadError: "Erreur durant le chargement",
                    labelFileProcessing: "En cours de téléversement",
                    labelFileLoading: "Chargement",
                    labelFileProcessingComplete: "Téléversement terminé",
                    labelFileProcessingAborted: "Téléversement annulé",
                    labelFileWaitingForSize: "En attente de la taille",
                    labelFileSizeNotAvailable: "Taille non disponible",
                    labelTapToUndo: "Appuyez pour revenir en arrière",
                    labelTapToRetry: "Appuyez pour réessayer",
                    labelTapToCancel: "Appuyez pour annuler",
                    labelIdle: "Glissez-déposez votre document ou <span class='filepond--label-action'> parcourir </span>",
                    forceRevert: true,
                    allowRemove: true,
                    allowMultiple: false,
                    allowReplace: false,
                    disabled: !!readOnly,
                    credits: false,
                    maxFiles: 1,
                });


                // Vérifier si l'ID d'input correspond à une entrée dans le tableau de documents
                if (documents.hasOwnProperty(inputId)) {
                    // Construire l'objet de fichier
                    var fichier = {
                        source: documents[inputId].libelle,
                        options: {
                            type: 'local', // Type de fichier local
                        }
                    };
                    // Ajouter le fichier à FilePond
                    pond.addFiles([fichier]);
                }
            });

            const submitButton = document.querySelector('input[name="document[_nav][_submit]"]');
            var count = 0;
            if (submitButton) {
                // submitButton.addEventListener('click', function(event) {
                //     if(count === 0){
                //         event.preventDefault();
                //         $('.modal').modal('show');
                //     }
                //
                //     $('.modal').on('click', '.confirm-btn', function() {
                //         count = 1;
                //         $(submitButton).click();
                //     });
                // });
            }

        });
    }
}, 100)

$(document).ready(function () {
    if (currentUrl.indexOf("/inscription") !== -1) {
        $('select').selectpicker();
    }

    $('[data-toggle="tooltip"]').tooltip({
        placement: 'top',
    });

    //permet de split la paire nom/prénom dans chaque input correspondant
    $(function() {
        $("#nomDirecteurThese-autocomplete, #prenomDirecteurThese-autocomplete").on('autocompleteselect', function(event, data) {
            setTimeout(function() {
                $("#nomDirecteurThese-autocomplete").val(data.item.extras.nom);
                $("#nomDirecteurThese").val(data.item.id);
            }, 50);
            setTimeout(function() {
                $("#prenomDirecteurThese-autocomplete").val(data.item.extras.prenoms);
                $("#prenomDirecteurThese").val(data.item.id);
            }, 50);
            $("#prenomDirecteurThese-autocomplete").val(data.item.extras.prenoms);
            $("#emailDirecteurThese").val(data.item.extras.email);
        })

        $("#nomCodirecteurThese-autocomplete, #prenomCodirecteurThese-autocomplete").on('autocompleteselect', function(event, data) {
            setTimeout(function() {
                $("#nomCodirecteurThese-autocomplete").val(data.item.extras.nom);
                $("#nomCodirecteurThese").val(data.item.id);
            }, 50);
            setTimeout(function() {
                $("#prenomCodirecteurThese-autocomplete").val(data.item.extras.prenoms);
                $("#prenomCodirecteurThese").val(data.item.id);
            }, 50);
            $("#prenomCodirecteurThese-autocomplete").val(data.item.extras.prenoms);
            $("#emailCodirecteurThese").val(data.item.extras.email);
        })
    })
});

