package com.Neighborly.service;

import com.Neighborly.dao.DocumentDAO;
import com.Neighborly.model.DocumentModel;
import java.util.List;

public class DocumentService {

    private final DocumentDAO dao = new DocumentDAO();

    public String validate(String documentType, String fullName, String dateOfBirth, String address, String phone) {

        if (documentType == null || documentType.trim().isEmpty())
            return "Please select a valid document type";

        if (fullName == null || fullName.trim().isEmpty())
            return "Full name is required";

        if (!fullName.trim().matches("[a-zA-Z ]+"))
            return "Full name must contain letters only";

        if (dateOfBirth == null || dateOfBirth.trim().isEmpty())
            return "Date of birth is required";

        if (address == null || address.trim().isEmpty())
            return "Address is required";

        if (phone == null || phone.trim().isEmpty())
            return "Phone number is required";

        if (!phone.trim().matches("\\d{10}"))
            return "Phone number must be 10 digits";

        return null;
    }

    public void applyForDocument(int userId, String documentType, String fullName, String dateOfBirth, String address,
            String phone, String additionalInfo) throws Exception {
        dao.applyForDocument(userId, documentType.trim(), fullName.trim(), dateOfBirth.trim(), address.trim(),
                phone.trim(), additionalInfo != null ? additionalInfo.trim() : "");
    }

    public List<DocumentModel> getDocumentsByUserId(int userId) throws Exception {
        return dao.getDocumentsByUserId(userId);
    }

    public DocumentModel getDocumentByIdAndUser(int documentId, int userId) throws Exception {
        return dao.getDocumentByIdAndUser(documentId, userId);
    }

    public DocumentModel getDocumentByTypeAndUser(String documentType, int userId) throws Exception {
        return dao.getDocumentByTypeAndUser(documentType, userId);
    }
}