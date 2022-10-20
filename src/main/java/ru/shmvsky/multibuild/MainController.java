package ru.shmvsky.multibuild;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MainController {

    @GetMapping
    @ResponseBody
    public String index() {
        return "Hello World";
    }

}
