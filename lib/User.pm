package User;
use Mojo::Base -base, -async_await, -signatures;
use Mojo::Promise;
use Data::Fake qw/Core Names Text Dates/;

has _profile_p    => sub { undef };
has _fake_profile => fake_hash(
    {
        name     => fake_name(),
        birthday => fake_past_datetime("%Y-%m-%d"),
        gender   => fake_pick(qw/Male Female Other/)
    }
);

async sub get_profile_p ( $self ) {

    # simulate a service that delays 1~3 secs to resolve/fail
    # and that fails 1/5 (20%) of times.
    $self->_profile_p(
        Mojo::Promise->new(
            sub ( $resolve, $reject ) {

                # time will take to resolve
                my $delay = int( rand(3) );
                Mojo::IOLoop->timer(
                    $delay => sub {

                        if ( int rand 4 ) {    # will be fullfilled
                            my $profile = $self->_fake_profile();
                            $profile->{delay} = $delay;
                            $resolve->($profile);
                        } else {               # will be rejected

                            $reject->('Fake error');
                        }
                    }
                );
            }
        )
    ) unless $self->_profile_p;

    return $self->_profile_p;
}

1;

=pod

=head1 Asynchronous User

We use this as example on how to create asynchronous code in a modular manner.
This represent an C<User> module that has an async operation: get its profile.

The module creates a fake data that represents user profile and add some random
delay to simulate some slow operation (a database fetch or an http request).
The idea is to teach us how to design a module that makes this async operation,
and how to use it. 


=cut

