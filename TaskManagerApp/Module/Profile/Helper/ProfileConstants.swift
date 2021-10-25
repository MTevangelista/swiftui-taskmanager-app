public enum ProfileConstants {
    
    public enum Color {
        public static let whiteAndBlack = "whiteAndBlack"
    }
    
    public enum Icon {
        public static let checkmark = "checkmark"
    }
    
    public enum Alert {
        public static let title = "Task Manager"
        public static let successfullyUpdatedData = "Dados atualizados com sucesso"
        public static let ok = "OK"
    }
    
    public enum Navigation {
        public static let barTitle = "Editar Perfil"
        public static let selectGender = "Escolha o gênero"
        public static let gender = "Gênero"
    }
    
    public enum Form {
        public static let headerTitle = "Dados cadastrais"
    }
    
    public enum Field {
        public static let name = (title: "Nome", placeholder: "Digite o nome")
        public static let email = "E-mail"
        public static let cpf = "CPF"
        public static let phone = (title: "Celular", placeholder: "Digite seu celular")
        public static let birthday = (title: "Aniversário", placeholder: "Digite sua data de nascimento")
    }
    
    public enum ErrorMessage {
        public static let invalidName = "Nome deve ter mais de 3 caracteres"
        public static let invalidPhone = "Entre com DDD + 8 ou 9 digitos"
        public static let invalidDate = "Data deve ser dd/MM/yyyy"
    }
    
}
