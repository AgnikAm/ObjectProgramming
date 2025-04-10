<?php

namespace App\Form;

use App\Entity\Order;
use App\Entity\User;
use App\Entity\product;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class OrderType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('totalPrice')
            ->add('customerEmail')
            ->add('product', EntityType::class, [
                'class' => product::class,
'choice_label' => 'id',
'multiple' => true,
            ])
            ->add('user', EntityType::class, [
                'class' => User::class,
'choice_label' => 'id',
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Order::class,
        ]);
    }
}
