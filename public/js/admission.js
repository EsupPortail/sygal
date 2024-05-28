/* global FilePond, FilePondPluginFileValidateType, FilePondPluginPdfPreview */
/**
 * @typedef {Object} FilePond
 * @property {function} registerPlugin
 * @property {function} create
 * @property {function} addFiles
 */

/** @type {FilePond} */
var FilePond;

//fonction affichant ou non les div en fonction de boutons radios
function showOrNotDiv(radiobutton, additionnalFields) {
    radiobutton.forEach(function (radio) {
        radio.addEventListener('change', function () {
            if (radio.checked && radio.value === "1") {
                additionnalFields.style.display = 'block';
            } else {
                additionnalFields.style.display = 'none';
            }
        });

        if (radio.checked && radio.value === "1") {
            additionnalFields.style.display = 'block';
        }
    });
}

function updateButtonsState(isButtonDisabled) {
    const previousButton = document.querySelector('.multipage-nav.previous');
    const nextButton = document.querySelector('.multipage-nav.next');
    const submitButton = document.querySelector('.multipage-nav.submit');

    if(previousButton){
        previousButton.disabled = isButtonDisabled;
    }
    if(nextButton){
        nextButton.disabled = isButtonDisabled;
    }
    if(submitButton){
        submitButton.disabled = isButtonDisabled;
    }

    // Mettez à jour les classes et les infobulles
    [previousButton, nextButton, submitButton].forEach(button => {
        if(button){
            if (isButtonDisabled) {
                button.classList.add('disabled');
                button.setAttribute('title', 'Veuillez renseigner un message pour changer d\'étape');
            } else {
                button.classList.remove('disabled');
                button.removeAttribute('title');
            }
        }
    });
}

function setupAutocompleteVillesFrancaises(inputId, codeId, postalId) {
    $(inputId).autocomplete({
        source: function(request, response) {
            $.ajax({
                url: 'https://geo.api.gouv.fr/communes',
                data: {
                    nom: request.term,
                    fields: 'nom,code,codesPostaux',
                    limit: 5,
                    boost: 'population'
                },
                success: function(data) {
                    const suggestions = [];
                    data.forEach(function(ville) {
                        suggestions.push({
                            label: ville.nom,
                            code: ville.code,
                            codePostal: ville.codesPostaux[0]
                        });
                    });
                    response(suggestions);
                }
            });
        },
        minLength: 2,
        select: function(event, ui) {
            $(inputId).val(ui.item.label);
            $(codeId).val(ui.item.code);
            $(postalId).val(ui.item.codePostal);
            return false;
        }
    });
}

function detectModalStatutAdmissionAppears() {
    const accessButtonCommentairesAdmission = document.querySelector('.commentaires-ajoutes-card');
    if(accessButtonCommentairesAdmission){
        accessButtonCommentairesAdmission.addEventListener('click', function(event) {
            event.preventDefault();
            $('.modal').modal('hide');
            const divId = "modalShowCommentairesAdmission";
            const commentairesDiv = document.getElementById(divId);

            //si la div existe déjà, on la supprime
            const existingDiv = document.querySelector("body > #" + divId);
            if (existingDiv) {
                existingDiv.remove();
            }
            document.body.appendChild(commentairesDiv);
            $('#modalShowCommentairesAdmission').modal('show');
        });
    }
}

function handleDirectionAutocompleteSelect(nomAutocomplete, prenomAutocomplete, nomField, prenomField, emailField, data) {
    setTimeout(function() {
        nomAutocomplete.val(data.item.extras.nom);
        nomField.val(data.item.id);
    }, 50);
    setTimeout(function() {
        prenomAutocomplete.val(data.item.extras.prenoms);
        prenomField.val(data.item.id);
    }, 50);
    prenomAutocomplete.val(data.item.extras.prenoms);
    emailField.val(data.item.extras.email);
}

const currentUrl = window.location.href;
document.addEventListener("DOMContentLoaded", function() {
    //permet de afficher/cacher le textarea observations pour le gestionnaire
    const commentairesDiv = document.querySelector(".commentaires-gestionnaire");
    const radioButtons = document.querySelectorAll('.observations-gestionnaire .multicheckbox input[type="radio"]');

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

        const label = radioButton.parentElement;
        if (radioButton.checked) {
            label.classList.add('selected');
        }
        if(radioButton.classList.contains('complet') && label.classList.contains('selected') || radioButton.classList.contains('incomplet') && !radioButton.checked){
            commentairesDiv.style.display = "none";
        }
    });

    //Gestion des commentaires du gestionnaire -> afin de pouvoir passer ou non à une autre étape
    const boutonGestionnaireIncomplet = document.querySelector('.bouton-gestionnaire.incomplet');
    const boutonGestionnaireComplet = document.querySelector('.bouton-gestionnaire.complet');


    //Activation de tinyMCE pour le champ commentaires des gestionnaires
    tinymce.remove();
    tinymce.init({
        selector: '.description_commentaires_gestionnaire',
        toolbar: 'undo redo | bold italic | bullist numlist',
        plugins: 'lists link',
        statusbar: true,
        resize: true,
        browser_spellcheck: true,
        branding: false,
        language: 'fr_FR',
        menu: {},
        link_context_toolbar: true,
        setup: function (editor) {
            function handleEditorChange() {
                const isButtonDisabled = boutonGestionnaireIncomplet.checked && editor.getContent().trim() === '';
                updateButtonsState(isButtonDisabled);
            }
            if (boutonGestionnaireComplet) {
                boutonGestionnaireComplet.addEventListener('change',handleEditorChange)
            }
            if (boutonGestionnaireIncomplet) {
                boutonGestionnaireIncomplet.addEventListener('change', handleEditorChange)
            }
            // Réagir lors du changement de contenu
            editor.on('input', handleEditorChange)
            editor.on('NodeChange', handleEditorChange)
        }
    });

    //Affichage du récapitulatif des commentaires du dossier d'admission
    const accessButtonCommentairesAdmission = document.querySelector('.commentaires-ajoutes-card');
    if(accessButtonCommentairesAdmission){
        accessButtonCommentairesAdmission.addEventListener('click', function(event) {
            event.preventDefault();
            $('#modalShowCommentairesAdmission').modal('show');
        });
    }

    if (currentUrl.indexOf("/etudiant") !== -1) {
        //désactive la possibilité de changer la civilité
        $('input:radio[name="etudiant[sexe]"]:not(:checked)').attr('disabled', true);

        const btn_infos_ine = document.querySelector('.info-ine-btn');
        if (btn_infos_ine) {
            btn_infos_ine.addEventListener('click', function (e) {
                e.preventDefault()
                $('#modalInfosIne').modal('show');
            })
        }

        const diplomeRadios = document.querySelectorAll('input[name="etudiant[niveauEtude]"]');
        const additionalFieldsDiplome = document.getElementById('additional_fields_diplome');
        const additionalFieldsAutre = document.getElementById('additional_fields_autre');

        additionalFieldsDiplome.style.display = 'none';
        additionalFieldsAutre.style.display = 'none';

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

        // -------------------GESTION VILLES FORM----------------------------
        function toggleCountryVisibility() {
            const selectedCountry = $('[data-id="adresseCodePays"] .filter-option-inner-inner').text().trim();
            //Si le pays sélectionné est France, on affiche le champ Code postal/Ville
            if (selectedCountry === 'France' || selectedCountry === 'Sélectionnez une option') {
                $('.adresse-cp-ville-etrangere').hide();
                $('.adresse-nom-commune').show();
                $('.adresse-code-postal').show();
            } else {
                $('.adresse-cp-ville-etrangere').show();
                $('.adresse-nom-commune').hide();
                $('.adresse-code-postal').hide();
            }
        }

        $(document).ready(function() {
            setupAutocompleteVillesFrancaises('#adresseNomCommune', '#adresseCodeCommune', '#adresseCodePostal');
            setupAutocompleteVillesFrancaises('#libelleCommuneNaissance', '#codeCommuneNaissance', '');
            toggleCountryVisibility();

            const targetNode = document.querySelector('[data-id="adresseCodePays"]');
            const observer = new MutationObserver(toggleCountryVisibility);

            const config = { attributes: true, attributeFilter: ['title'] };
            observer.observe(targetNode, config);

            $('#libelleCommuneNaissance').on('input', function() {
                $('#codeCommuneNaissance').val('');
            });

            $('#adresseNomCommune').on('input', function() {
                $('#adresseCodeCommune').val('');
            });
        });
    }

    if (currentUrl.indexOf("/inscription") !== -1) {
        const confidentialiteRadios = document.querySelectorAll('input[name="inscription[confidentialite]"]');
        const cotutelleRadios = document.querySelectorAll('input[name="inscription[coTutelle]"]');
        const codirectionRadios = document.querySelectorAll('input[name="inscription[coDirection]"]');
        const additionalFieldsConfidentialite = document.getElementById('additionalFieldsConfidentialite');
        const additionalFieldsCotutelle = document.getElementById('additionalFieldsCotutelle');
        const additionalFieldsCodirection = document.getElementById('additionalFieldsCodirection');

        additionalFieldsConfidentialite.style.display = 'none';
        additionalFieldsCotutelle.style.display = 'none';
        additionalFieldsCodirection.style.display = 'none';
        showOrNotDiv(confidentialiteRadios, additionalFieldsConfidentialite)
        showOrNotDiv(cotutelleRadios, additionalFieldsCotutelle)
        showOrNotDiv(codirectionRadios, additionalFieldsCodirection)
    }

    if (currentUrl.indexOf("/financement") !== -1) {
        const contratDoctoralRadios = document.querySelectorAll('input[name="financement[contratDoctoral]"]');
        const additionalFieldscontratDoctoral = document.getElementById('additional_fields_contrat_doctoral');

        additionalFieldscontratDoctoral.style.display = 'none';
        showOrNotDiv(contratDoctoralRadios, additionalFieldscontratDoctoral)

        const infosDoctorantSalarieRadios = document.querySelectorAll('input[name="financement[estSalarie]"]');
        const additionalFieldsInfosDoctorantSalarie = document.getElementById('additional_fields_infos_salaries');

        additionalFieldsInfosDoctorantSalarie.style.display = 'none';
        showOrNotDiv(infosDoctorantSalarieRadios, additionalFieldsInfosDoctorantSalarie)

        //Si contratDoctoral est à oui, on sélectionne automatiquement temps complet (oui), et estSalarie (oui),
        //et grise les autres possibilités
        $('input[name="financement[contratDoctoral]"]').on('change', function () {
            if ($(this).val() === '1') {
                $('input[name="financement[tempsTravail]"][value="1"]').prop('checked', true);
                $('input[name="financement[estSalarie]"][value="1"]').prop('checked', true);

                $('input[name="financement[tempsTravail]"][value="2"]').prop('disabled', true);
                $('input[name="financement[estSalarie]"][value="0"]').prop('disabled', true);
            } else {
                $('input[name="financement[tempsTravail]"][value="2"]').prop('disabled', false);
                $('input[name="financement[estSalarie]"][value="0"]').prop('disabled', false);
            }
        });
    }

    if (currentUrl.indexOf("/document") !== -1) {
        FilePond.registerPlugin(FilePondPluginFileValidateType);
        FilePond.registerPlugin(FilePondPluginPdfPreview);

        let serverResponse = '';
        // Sélectionner tous les champs de fichier et les transformer en champs FilePond
        $('input[type="file"]').each(function () {
            const inputId = $(this).attr('id');
            const pond = FilePond.create(this, {
                acceptedFileTypes: ['application/pdf', 'image/png', 'image/jpeg'],
                server: {
                    url: '/admission',
                    process: {
                        url: '/enregistrer-document/' + individuId + '/' + inputId,
                        onerror: (response) =>
                            serverResponse = JSON.parse(response),
                    },
                    revert: {
                        url: '/supprimer-document/' + individuId + '/' + inputId,
                        onerror: (response) =>
                            serverResponse = JSON.parse(response),
                    },
                    load: (source, load, error) => {
                        fetch('/admission/telecharger-document/' + individuId + '/' + inputId + '?name='+documents[inputId].libelle, {
                            method: 'GET',
                        }).then(response => {
                            if (!response.ok) {
                                error("Erreur de chargement")
                                throw new Error("Erreur de chargement");
                            }
                            response.blob().then(function(myBlob) {
                                load(myBlob)
                            });
                            if(inputId === "ADMISSION_CHARTE_DOCTORAT") {
                                $('.charte-doctorale-operations').show();
                            }
                        }).catch(error => {
                            console.log(error)
                        });
                    },
                    remove: (source, load, error) => {
                        fetch('/admission/supprimer-document/' + individuId + '/' + inputId, {
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
                "beforeRemoveFile": function () {
                    return confirm("Êtes-vous sûr de vouloir supprimer ce fichier ?");
                },
                "labelFileProcessingError": () => {
                    return serverResponse.errors;
                },
                "labelFileProcessingRevertError": () => {
                    return serverResponse.errors;
                },
                "labelFileRemoveError": () => {
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
                labelIdle: "Glissez-déposez votre document ou <span class='filepond--label-action'> parcourir </span> <br>(pdf/jpg/jpeg acceptés)",
                forceRevert: true,
                allowRemove: inputId !== "ADMISSION_CHARTE_DOCTORAT",
                allowMultiple: false,
                allowReplace: false,
                credits: false,
                maxFiles: 1,
                pdfPreviewHeight: inputId === "ADMISSION_CHARTE_DOCTORAT" ? "8000" : false,
                pdfComponentExtraParams: inputId === "ADMISSION_CHARTE_DOCTORAT" ? 'toolbar=0&page=1' : false,
                allowPdfPreview: inputId === "ADMISSION_CHARTE_DOCTORAT",
            });


            if (documents.hasOwnProperty(inputId)) {
                var fichier = {
                    source: documents[inputId].libelle,
                    options: {
                        type: 'local', // Type de fichier local
                    }
                }
                if(inputId !== "ADMISSION_CHARTE_DOCTORAT") {
                    fichier.options['file'] = {
                        name: documents[inputId].libelle,
                        size: documents[inputId].size,
                    };
                    // Ajouter le fichier à FilePond
                    pond.addFiles([fichier]);
                }
            }

            //GESTION DE LA CHARTE DOCTORALE
            const accessButtonCharteDoctorale = document.querySelector('.access-charte-doctorat-btn');
            const fileCharteDoctoratDiv = document.querySelector('.file-charte-doctorat');

            if(accessButtonCharteDoctorale){
                accessButtonCharteDoctorale.addEventListener('click', function(event) {
                    event.preventDefault();
                    $('#modalShowCharteDoctorale').modal('show');
                    //Chargement de la charte doctorale lors de la première apparition de la popup, sinon le fichier peut ne pas apparaitre
                    if (documents.hasOwnProperty(inputId)) {
                        if(inputId === "ADMISSION_CHARTE_DOCTORAT") {
                            // Ajouter le fichier à FilePond
                            pond.addFiles([fichier]);
                        }
                    }
                    fileCharteDoctoratDiv.style.display = 'block';
                });
            }

            //GESTION DE LA CONVENTION DE FORMATION DOCTORALE
            const conventionFormationDoctorale = document.getElementById("conventionFormationDoctoraleObject");
            const fileConventionFormationDoctoraleDiv = document.querySelector('.file-convention-formation-doctorale');
            const loadingIndicator = document.getElementById("loading-indicator");
            if(conventionFormationDoctorale){
                conventionFormationDoctorale.setAttribute("height", "0px");
                conventionFormationDoctorale.addEventListener("load", function () {
                    loadingIndicator.style.display = "none";
                    fileConventionFormationDoctoraleDiv.style.height = "auto";
                    $('.convention-formation-doctorale-operations').show();
                    conventionFormationDoctorale.setAttribute("height", "4000px");
                });
            }
            if(loadingIndicator){
                loadingIndicator.style.display = "block";
            }

            const accessButtonConventionFormationDoctorale = document.querySelectorAll('.access-conv-form-doct-btn');
            if(accessButtonConventionFormationDoctorale){
                accessButtonConventionFormationDoctorale.forEach(function(button) {
                    button.addEventListener('click', function(event) {
                        event.preventDefault();
                        $('#modalShowConventionFormationDoctorale').modal('show');
                        fileConventionFormationDoctoraleDiv.style.display = 'block';
                    });
                });
            }
        });

        const buttons = document.querySelectorAll('.access_validation_operation, .access_devalidation_operation, .access-suppression-operation-btn, .access-notification-dossier-incomplet-btn');
        buttons.forEach(function(button) {
            button.addEventListener('click', function(event) {
                event.preventDefault();
                const modalId = '#modalShowConfirmation' + button.dataset.operation;

                //Gestion des modals lorsqu'il y a deux modals superposés (convention de formation doctorale et les opérations)
                const targetElement = document.querySelector('.access-conv-form-doct-btn') || document.querySelector('.access-charte-doctorat-btn');
                const modal = document.getElementById('modalShowConfirmation' + button.dataset.operation);
                if(modal){
                    if(targetElement){
                        targetElement.insertAdjacentElement('afterend', modal);
                    }
                    $('#modalShowConventionFormationDoctorale').modal('hide');
                    $('#modalShowCharteDoctorale').modal('hide');
                }
                $(modalId).modal('show');
            });
        });

        const validations_action_operation = document.querySelectorAll('.validation-operation-btn');
        if(validations_action_operation){
            validations_action_operation.forEach(function(validationOperationBtn) {
                validationOperationBtn.addEventListener('click', function () {
                    validationOperationBtn.classList.add('loading-file');
                    document.body.style.pointerEvents = 'none';
                    document.body.style.cursor = 'wait';
                });
            });
        }

        //Ajout de TinyMCE pour la convention de formation doctorale
        if (currentUrl.includes('convention-formation/modifier/') || currentUrl.includes('convention-formation/ajouter/')) {
            tinymce.remove();
            tinymce.init({
                selector: 'textarea',
                toolbar: 'undo redo | bold italic | bullist numlist | table link',
                plugins: 'lists link table',
                table_toolbar: "tabledelete | tableinsertrowbefore tableinsertrowafter tabledeleterow | tableinsertcolbefore tableinsertcolafter tabledeletecol",
                statusbar: true,
                resize: true,
                browser_spellcheck: true,
                branding: false,
                language: 'fr_FR',
                menu: {},

                body_id: 'contenu',
                link_context_toolbar: true,
            });
        }

        //GESTION DU RÉCAPITULATIF DU DOSSIER
        const lienRecapitulatif = document.querySelector('.access-recap-signe-btn');
        const divRecapitulatif = document.getElementById('file-recap-signe-container');

        if(lienRecapitulatif){
            lienRecapitulatif.addEventListener('click', function(event) {
                event.preventDefault();

                if (divRecapitulatif.style.display === 'none' || divRecapitulatif.style.display === '') {
                    divRecapitulatif.style.display = 'block';
                } else {
                    divRecapitulatif.style.display = 'none';
                }
            });
        }
    }
})

$(document).ready(function () {
    if (currentUrl.indexOf("/etudiant") !== -1 ||currentUrl.indexOf("/inscription") !== -1 || currentUrl.indexOf("/financement") !== -1) {
        $('select').not('select[name="etudiant[anneeDobtentionDiplomeNational]"]').selectpicker();
    }

    $('[data-toggle="tooltip"]').tooltip({
        placement: 'top',
    });

    var urlWithoutParams = currentUrl.split('?')[0];
    var segments = urlWithoutParams.split('/');
    if(segments[segments.length - 1] === 'admission'){
        // pour afficher la modal des commentaires d'un dossier qui est déjà dans une modale
        setInterval(detectModalStatutAdmissionAppears, 1500);
    }

    //permet de split la paire nom/prénom dans chaque input correspondant des directeurs/co-directeurs à l'étape inscription
    $(function() {
        const nomDirecteurAutocomplete = $("#nomDirecteurThese-autocomplete");
        const prenomDirecteurAutocomplete = $("#prenomDirecteurThese-autocomplete");
        const nomDirecteur = $("#nomDirecteurThese");
        const prenomDirecteur = $("#prenomDirecteurThese");
        const emailDirecteur = $("#emailDirecteurThese");

        nomDirecteurAutocomplete.on('autocompleteselect', function(event, data) {
            handleDirectionAutocompleteSelect(nomDirecteurAutocomplete, prenomDirecteurAutocomplete, nomDirecteur, prenomDirecteur, emailDirecteur, data);
        });

        prenomDirecteurAutocomplete.on('autocompleteselect', function(event, data) {
            handleDirectionAutocompleteSelect(nomDirecteurAutocomplete, prenomDirecteurAutocomplete, nomDirecteur, prenomDirecteur, emailDirecteur, data);
        });

        nomDirecteurAutocomplete.on('input', function() {
            nomDirecteur.val(null);
            prenomDirecteur.val(null);
        });

        prenomDirecteurAutocomplete.on('input', function() {
            nomDirecteur.val(null);
            prenomDirecteur.val(null);
        });

        const nomCodirecteurAutocomplete = $("#nomCodirecteurThese-autocomplete");
        const prenomCodirecteurAutocomplete = $("#prenomCodirecteurThese-autocomplete");
        const nomCodirecteur = $("#nomCodirecteurThese");
        const prenomCodirecteur = $("#prenomCodirecteurThese");
        const emailCodirecteur = $("#emailCodirecteurThese");

        nomCodirecteurAutocomplete.on('autocompleteselect', function(event, data) {
            handleDirectionAutocompleteSelect(nomCodirecteurAutocomplete, prenomCodirecteurAutocomplete, nomCodirecteur, prenomCodirecteur, emailCodirecteur, data);
        });

        prenomCodirecteurAutocomplete.on('autocompleteselect', function(event, data) {
            handleDirectionAutocompleteSelect(nomCodirecteurAutocomplete, prenomCodirecteurAutocomplete, nomCodirecteur, prenomCodirecteur, emailCodirecteur, data);
        });

        nomCodirecteurAutocomplete.on('input', function() {
            nomCodirecteur.val(null);
            prenomCodirecteur.val(null);
        });

        prenomCodirecteurAutocomplete.on('input', function() {
            nomCodirecteur.val(null);
            prenomCodirecteur.val(null);
        });
    })
});