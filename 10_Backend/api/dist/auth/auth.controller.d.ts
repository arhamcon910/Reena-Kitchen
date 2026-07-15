import { AuthService } from './auth.service';
import { RegisterDto } from './dto/register.dto';
export declare class AuthController {
    private authService;
    constructor(authService: AuthService);
    register(dto: RegisterDto): Promise<{
        accessToken: string;
        user: {
            id: string;
            email: string;
            name: string | null;
        };
    }>;
    login(req: {
        user: {
            id: string;
            email: string;
        };
    }): {
        accessToken: string;
        user: {
            id: string;
            email: string;
        };
    };
    me(req: {
        user: {
            id: string;
            email: string;
        };
    }): {
        id: string;
        email: string;
    };
}
