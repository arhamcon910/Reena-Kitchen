import { UsersService } from './users.service';
import { UpdateUserDto } from './dto/update-user.dto';
export declare class UsersController {
    private usersService;
    constructor(usersService: UsersService);
    me(req: {
        user: {
            id: string;
            email: string;
        };
    }): Promise<{
        name: string | null;
        id: string;
        email: string;
        password: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
    findOne(id: string): Promise<{
        name: string | null;
        id: string;
        email: string;
        password: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
    update(req: {
        user: {
            id: string;
        };
    }, dto: UpdateUserDto): Promise<{
        name: string | null;
        id: string;
        email: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
    remove(req: {
        user: {
            id: string;
        };
    }): Promise<{
        message: string;
    }>;
}
