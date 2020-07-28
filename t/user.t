use Test::More;
use Mojo::Base -strict, -signatures, -async_await;
use Syntax::Keyword::Try;
use Mojo::Promise;
use User;

use constant DEBUG => 0;

# Make tests async
async sub tests {

    # create users and solve each one
    {
        my @users = map { User->new } 1 .. 5;

        my $got;
        foreach my $user (@users) {

            # try to get user profile
            try { $got = await $user->get_profile_p }
            catch {
                # if error: check error message
                like $@, qr/Fake error/, "Right error message" or note explain $@;
                next;
            }

            # got it, so show the data
            ok $got, "Got something";
            note explain $got if DEBUG;
        }
    }

    # create users and resolve at same time all
    {
        my @users = map { User->new->get_profile_p } 1 .. 5;

        my $p = Mojo::Promise->all_settled(@users)->then(
            sub {
                ok 1, "All promises settled at same time";
                diag explain @_ if DEBUG;
            }
        );

        await $p;
    }

    done_testing;
}

tests()->wait;
