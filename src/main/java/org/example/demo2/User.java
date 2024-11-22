package org.example.demo2;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class User {
    private Integer id=idgen++;
    private String firstname;
    private String lastname;
    private String phoneNumber;
    private String password;
    private  static int idgen=1;


    public User(String firstname, String lastname, String phoneNumber,String password) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.phoneNumber = phoneNumber;
        this.password=password;
    }


}
