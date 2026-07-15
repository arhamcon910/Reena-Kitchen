import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { UsersService } from '../users/users.service';
import { RegisterDto } from './dto/register.dto';
export declare class AuthService {
    private usersService;
    private jwtService;
    private configService;
    constructor(usersService: UsersService, jwtService: JwtService, configService: ConfigService);
    register(dto: RegisterDto): Promise<{
        accessToken: string;
        user: {
            id: string;
            email: string;
            name: string | null;
        };
    }>;
    validateUser(email: string, password: string): Promise<{
        id: string;
        email: string;
        name: string | null;
    } | null>;
    login(user: {
        id: string;
        email: string;
    }): {
        accessToken: string;
        user: {
            id: string;
            email: string;
        };
    };
    private signToken;
    private sanitize;
}
