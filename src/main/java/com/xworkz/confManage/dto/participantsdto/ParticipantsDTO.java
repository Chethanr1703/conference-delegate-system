package com.xworkz.confManage.dto.participantsdto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ParticipantsDTO {

    private int id;

    @NotNull(message = "Full name is required")
    @Size(min = 3, max = 40, message = "Name must be between 3 and 40 characters")
    @Pattern(regexp = "^[A-Za-z ]+$", message = "Name must contain only letters")
    private String fullName;

    @NotNull(message = "Email is required")
    @Pattern(
            regexp = "^[a-zA-Z0-9._%+-]+@gmail\\.com$",
            message = "Email must be a valid gmail address"
    )
    private String email;

    @NotNull(message = "Mobile number is required")
    @Pattern(
            regexp = "^[6-9][0-9]{9}$",
            message = "Mobile number must be valid"
    )
    private String mobile;

    @NotNull(message = "Organization is required")
    @Size(min = 2, max = 100, message = "Organization must be between 2 and 100 characters")
    private String organization;

    @NotNull(message = "Attendance status is required")
    @Pattern(
            regexp = "Yes|No",
            message = "Attendance must be YES or NO"
    )
    private String attending;

    /* Foreign Keys */

    @NotNull(message = "Conference ID is required")
    private Integer conferenceId;


    private Integer delegateId;
}